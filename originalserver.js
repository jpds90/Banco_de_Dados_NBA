const express = require('express');
const { Pool } = require('pg');
const path = require('path');
const { exec } = require('child_process');
const fs = require('fs');
const { scrapeResults } = require('./script');



const app = express();
const port = 3099;

// Configuração do pool de conexão com o banco de dados
const pool = new Pool({
    user: 'admin',
    host: 'localhost',
    database: 'nba',
    password: '123456',
    port: 5432,
});

// Middleware para processar JSON
app.use(express.json()); // Aqui processamos JSON no corpo da requisição
app.use(express.urlencoded({ extended: true })); // Opcional, para processar dados URL-encoded


// Define o mecanismo de renderização para HTML
app.set('view engine', 'html');
app.engine('html', require('ejs').renderFile); // Usamos EJS para renderizar HTML dinâmico
app.use(express.static('public')); // Para arquivos estáticos, como CSS

// Página inicial com uma lista de tabelas disponíveis
app.get('/', async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
        `);
        const tables = result.rows.map(row => row.table_name);
        res.render('index', { tables });
    } catch (error) {
        console.error('Erro ao buscar tabelas:', error);
        res.status(500).send('Erro ao buscar tabelas');
    }
});

// Página para exibir os dados de uma tabela específica
app.get('/table/:name', async (req, res) => {
    const tableName = req.params.name;
    try {
        const result = await pool.query(`SELECT * FROM ${tableName}`);
        const rows = result.rows;
        const columns = result.fields.map(field => field.name); // Obtem os nomes das colunas
        res.render('table', { tableName, rows, columns });
    } catch (error) {
        console.error(`Erro ao buscar dados da tabela "${tableName}":`, error);
        res.status(500).send('Erro ao buscar dados da tabela');
    }
});

// Rota para exibir os links
app.get('/links', async (req, res) => {
    const client = await pool.connect();
    try {
        const result = await client.query('SELECT team_name, link, event_time FROM links');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao buscar dados dos links.');
    } finally {
        client.release();
    }
});

// Rota para limpar os dados de uma tabela específica
app.post('/clear-table', async (req, res) => {
    const { tableName } = req.body;

    if (!tableName) {
        return res.status(400).send('Nome da tabela não fornecido.');
    }

    const client = await pool.connect();
    try {
        // Limpar a tabela e reiniciar o ID
        await client.query(`TRUNCATE TABLE "${tableName}" RESTART IDENTITY CASCADE`);
        console.log(`Tabela "${tableName}" limpa e IDs reiniciados com sucesso!`);
        res.status(200).send(`Tabela "${tableName}" limpa e IDs reiniciados com sucesso!`);
    } catch (error) {
        console.error(`Erro ao limpar a tabela "${tableName}":`, error);
        res.status(500).send(`Erro ao limpar a tabela "${tableName}".`);
    } finally {
        client.release();
    }
});

app.post('/clear-all-tables-except-links', async (req, res) => {
    const client = await pool.connect();

    try {
        // Obter todas as tabelas no schema público
        const result = await client.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
        `);

        // Array de tabelas que não devem ser apagadas
        const excludedTables = ['odds', 'links'];

        // Filtrar as tabelas para excluir as que estão na lista de exclusão
        const tables = result.rows
            .map(row => row.table_name)
            .filter(table => !excludedTables.includes(table)); // Excluir odds e links

        if (tables.length === 0) {
            return res.status(200).send('Nenhuma tabela encontrada para apagar (exceto odds e links).');
        }

        // Apagar todas as tabelas, exceto as excluídas
        for (const table of tables) {
            await client.query(`DROP TABLE IF EXISTS "${table}" CASCADE`);
        }

        console.log('Todas as tabelas (exceto odds e links) foram apagadas com sucesso!');
        res.status(200).send('Todas as tabelas (exceto odds e links) foram apagadas com sucesso!');
    } catch (error) {
        console.error('Erro ao apagar as tabelas:', error);
        res.status(500).send('Erro ao apagar as tabelas.');
    } finally {
        client.release();
    }
});

// Rota para excluir odds
app.post('/delete-odds', async (req, res) => {
    const { ids } = req.body;

    if (!Array.isArray(ids) || ids.length === 0) {
        return res.status(400).json({ error: 'IDs inválidos ou ausentes.' });
    }

    try {
        const query = 'DELETE FROM odds WHERE id = ANY($1)';
        await pool.query(query, [ids]);
        res.status(200).json({ message: 'Odds excluídas com sucesso.' });
    } catch (error) {
        console.error('Erro ao excluir odds:', error);
        res.status(500).json({ error: 'Erro ao excluir odds.' });
    }
});

// Rota para executar o script odds.js
app.post('/execute-rank', (req, res) => {
    const oddsPath = path.join(__dirname, 'classificacao.js');
    exec(`node ${oddsPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erro ao executar o script Classificação: ${error.message}`);
            return res.status(500).send('Erro ao executar o script Classificação.');
        }
        if (stderr) {
            console.error(`Erro no script Classificação: ${stderr}`);
            return res.status(500).send('Erro ao executar o script Classificação.');
        }
        console.log(`Resultado do script Classificação: ${stdout}`);
        res.send('Script Classificação executado com sucesso.');
    });
});

// Rota para executar o script odds.js
app.post('/execute-oods', (req, res) => {
    const oddsPath = path.join(__dirname, 'odds.js');
    exec(`node ${oddsPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erro ao executar o script: ${error.message}`);
            return res.status(500).send('Erro ao executar o script.');
        }
        if (stderr) {
            console.error(`Erro no script: ${stderr}`);
            return res.status(500).send('Erro ao executar o script.');
        }
        console.log(`Resultado do script: ${stdout}`);
        res.send('Script Odds executado com sucesso.');
    });
});

// Rota para executar o script saveLinks.js
app.post('/execute-script', (req, res) => {
    const saveLinksPath = path.join(__dirname, 'public', 'saveLinks.js');
    exec(`node ${saveLinksPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erro ao executar o script: ${error.message}`);
            return res.status(500).send('Erro ao executar o script.');
        }
        if (stderr) {
            console.error(`Erro no script: ${stderr}`);
            return res.status(500).send('Erro ao executar o script.');
        }
        console.log(`Resultado do script: ${stdout}`);
        res.send('Script.js executado com sucesso.');
    });
});

// Rota para executar o script principal (script.js)
app.post('/execute-jogos', async (req, res) => {
    const { links } = req.body; // Links das equipes selecionadas

    if (!Array.isArray(links) || links.length === 0) {
        return res.status(400).send('Nenhum link selecionado.');
    }

    try {
        console.log('Links selecionados:', links);

        for (const link of links) {
            await scrapeResults(link); // Certifique-se de que a função foi importada
        }

        res.status(200).send('Jogos atualizados com sucesso!');
    } catch (error) {
        console.error('Erro ao atualizar jogos:', error);
        res.status(500).send('Erro ao atualizar jogos.');
    }
});

// Rota para buscar os dados das odds
app.get('/odds', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM odds');
        res.json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar dados do banco:', error);
        res.status(500).json({ error: 'Erro ao buscar dados do banco' });
    }
});



// Endpoint para calcular as médias e retornar os dados
// Endpoint para calcular as médias e retornar os dados
app.get('/team-averages', async (req, res) => {
    const { start_date, end_date } = req.query;

    if (!start_date || !end_date) {
        return res.status(400).json({ error: 'As datas de início e fim são necessárias.' });
    }

    // Adiciona o ano atual às datas
    const currentYear = new Date().getFullYear();
    const formattedStartDate = `${start_date}.`;
    const formattedEndDate = `${end_date}.`;

    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            // Verificar tabelas existentes
            const tablesResult = await pool.query(`
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_name = $1 OR table_name = $2
            `, [homeTable, awayTable]);

            const tableNames = tablesResult.rows.map(row => row.table_name);

            // Calcular média de pontos do time da casa
            let homeAvg = 0;
            if (tableNames.includes(homeTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT home_score, datahora 
                    FROM ${homeTable} 
                    WHERE home_team = $1
                    AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
                    ORDER BY datahora DESC
                    LIMIT 12
                `, [time_home, formattedStartDate, formattedEndDate]);

                const homeScores = homeScoresResult.rows
                    .map(row => parseInt(row.home_score, 10))
                    .filter(score => !isNaN(score));

                homeAvg = homeScores.length 
                    ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) 
                    : 0;
            }

            // Calcular média de pontos do time visitante
            let awayAvg = 0;
            if (tableNames.includes(awayTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT away_score, datahora 
                    FROM ${awayTable} 
                    WHERE away_team = $1
                    AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
                    ORDER BY datahora DESC
                    LIMIT 12
                `, [time_away, formattedStartDate, formattedEndDate]);

                const awayScores = awayScoresResult.rows
                    .map(row => parseInt(row.away_score, 10))
                    .filter(score => !isNaN(score));

                awayAvg = awayScores.length 
                    ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) 
                    : 0;
            }

            // Garantir soma inteira para total_pontos
            results.push({
                time_home,
                time_away,
                home_avg: homeAvg,
                away_avg: awayAvg,
                total_pontos: homeAvg + awayAvg, // Agora ambos já são inteiros
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/head-to-head-averages', async (req, res) => {
    try {
        // Buscar os jogos de odds para obter os times
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        // Percorrer os jogos e calcular as médias para cada confronto
        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            // Buscar confrontos diretos entre os times
            const confrontationResult = await pool.query(`
                SELECT home_score, away_score, home_team, away_team
                FROM ${homeTable}
                WHERE (home_team = $1 AND away_team = $2)
                   OR (home_team = $2 AND away_team = $1)
                ORDER BY id ASC
            `, [time_home, time_away]);

            const confrontations = confrontationResult.rows;

            // Calcular total de pontos feitos e pontos sofridos nos confrontos diretos
            let totalHomePoints = 0;
            let totalAwayPoints = 0;
            
            // Somar pontos feitos e pontos sofridos
            confrontations.forEach(row => {
                totalHomePoints += parseInt(row.home_score, 10) || 0;
                totalAwayPoints += parseInt(row.away_score, 10) || 0;
            });

            // Calcular a média de pontos
            const homeAveragePoints = confrontations.length > 0
                ? (totalHomePoints / confrontations.length).toFixed(2)
                : 0;

            const awayAveragePoints = confrontations.length > 0
                ? (totalAwayPoints / confrontations.length).toFixed(2)
                : 0;

            // Calcular o total de pontos no confronto
            const totalPoints = confrontations.length > 0
                ? ((totalHomePoints + totalAwayPoints) / confrontations.length).toFixed(2)
                : 0;

            // Adicionar os resultados para a resposta
            results.push({
                time_home,
                time_away,
                home_average_points: homeAveragePoints,
                away_average_points: awayAveragePoints,
                total_points: totalPoints,
            });
        }

        // Retornar os resultados para o cliente
        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/confrontations1', async (req, res) => {
    const { start_date, end_date } = req.query;

    if (!start_date || !end_date) {
        return res.status(400).json({ error: 'As datas de início e fim são necessárias.' });
    }

    // Adiciona o ano atual às datas
    const currentYear = new Date().getFullYear();
    const formattedStartDate = `${start_date}.`;
    const formattedEndDate = `${end_date}.`;

    // Log para verificar as datas enviadas
    console.log(`Data Início: ${formattedStartDate}`);
    console.log(`Data Fim: ${formattedEndDate}`);
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const confrontationData = [];

        for (const { time_home, time_away } of oddsRows) {
            // Envolver todo o processamento em um bloco try-catch para capturar erros por iteração
            try {
                const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
                const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

                // Buscar IDs do time da casa
                const homeIdsResult = await pool.query(`
                SELECT id, datahora
                FROM ${homeTable}
                WHERE home_team = $1 
                AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
            `, [time_home, formattedStartDate, formattedEndDate]);
                const homeIds = homeIdsResult.rows.map(row => row.id);

                console.log(`IDs extraídos para o time ${time_home}:`, homeIds);
                console.log(`Total de IDs para o time ${time_home}: ${homeIds.length}`);

                // Buscar IDs do time visitante
                const awayIdsResult = await pool.query(`
                    SELECT id, datahora
                    FROM ${awayTable}
                    WHERE home_team = $1 
                    AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
                `, [time_away, formattedStartDate, formattedEndDate]);
                const awayIds = awayIdsResult.rows.map(row => row.id);

                console.log(`IDs extraídos para o time ${time_away}:`, awayIds);
                console.log(`Total de IDs para o time ${time_away}: ${awayIds.length}`);

                const tablesResult = await pool.query(`
                    SELECT table_name 
                    FROM information_schema.tables 
                    WHERE table_name = $1 OR table_name = $2
                `, [homeTable, awayTable]);

                const tableNames = tablesResult.rows.map(row => row.table_name);

                if (tableNames.length === 0) {
                    console.log(`Nenhuma tabela encontrada para os times ${time_home} e ${time_away}`);
                    continue;
                }

                // Consultar confrontos diretos
                const confrontationResult = await pool.query(`
                    SELECT home_score, away_score, home_team, away_team
                    FROM ${homeTable}
                    WHERE (home_team = $1 AND away_team = $2)
                       OR (home_team = $2 AND away_team = $1)
                    ORDER BY id ASC
                `, [time_home, time_away]);

                let homeHomeWins = 0;
                let homeAwayWins = 0;
                let awayHomeWins = 0;
                let awayAwayWins = 0;
                let homePointsMade = 0;
                let awayPointsMade = 0;
                let homeGames = 0;
                let awayGames = 0;

                confrontationResult.rows.forEach(row => {
                    const homeScore = parseInt(row.home_score, 10);
                    const awayScore = parseInt(row.away_score, 10);

                    console.log(`Analisando jogo: ${row.home_team} vs ${row.away_team}`);
                    console.log(`Pontuação: ${row.home_score} (Home) vs ${row.away_score} (Away)`);

                    if (row.home_team === time_home) {
                        homePointsMade += homeScore;
                        homeGames++;
                    } else if (row.away_team === time_home) {
                        homePointsMade += awayScore;
                        awayGames++;
                    }

                    if (row.home_team === time_away) {
                        awayPointsMade += homeScore;
                        homeGames++;
                    } else if (row.away_team === time_away) {
                        awayPointsMade += awayScore;
                        awayGames++;
                    }

                    if (homeScore > awayScore) {
                        if (row.home_team === time_home) {
                            homeHomeWins++;
                            console.log(`Vitória para ${time_home} em casa.`);
                        } else if (row.home_team === time_away) {
                            awayHomeWins++;
                            console.log(`Vitória para ${time_away} em casa.`);
                        }
                    } else if (awayScore > homeScore) {
                        if (row.away_team === time_home) {
                            homeAwayWins++;
                            console.log(`Vitória para ${time_home} fora de casa.`);
                        } else if (row.away_team === time_away) {
                            awayAwayWins++;
                            console.log(`Vitória para ${time_away} fora de casa.`);
                        }
                    }
                });

                const homeAveragePoints = homeGames > 0 ? (homePointsMade / homeGames).toFixed(2) : 0;
                const awayAveragePoints = awayGames > 0 ? (awayPointsMade / awayGames).toFixed(2) : 0;
                const totalAveragePoints = parseFloat(homeAveragePoints) + parseFloat(awayAveragePoints);

                const homeWinsResult = await pool.query(`
                    SELECT id, home_score, away_score, datahora 
                    FROM ${homeTable}
                    WHERE id = ANY($1::int[])
                    AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
                `, [homeIds, formattedStartDate, formattedEndDate]);

                const homeTotalHomeWins = homeWinsResult.rows.filter(row =>
                    parseInt(row.home_score, 10) > parseInt(row.away_score, 10)
                ).length;

                console.log(`Total de Vitoria Casa: ${homeTotalHomeWins} `);
                const awayWinsResult = await pool.query(`
                    SELECT id, home_score, away_score, datahora 
                    FROM ${awayTable}
                    WHERE id = ANY($1::int[])
                    AND to_timestamp(datahora || '.' || EXTRACT(YEAR FROM CURRENT_DATE)::text, 'DD.MM.')::date BETWEEN to_timestamp($2, 'DD.MM.')::date AND to_timestamp($3, 'DD.MM.')::date
                `, [awayIds, formattedStartDate, formattedEndDate]);

                const awayTotalAwayWins = awayWinsResult.rows.filter(row =>
                    parseInt(row.away_score, 10) > parseInt(row.home_score, 10)
                ).length;

                console.log(`Total de Vitoria Fora: ${awayTotalAwayWins} `);
                const homeWinPercentage = homeIds.length > 0
                    ? ((homeTotalHomeWins / homeIds.length) * 100).toFixed(2)
                    : 0;

                const awayWinPercentage = awayIds.length > 0
                    ? ((awayTotalAwayWins / awayIds.length) * 100).toFixed(2)
                    : 0;

                confrontationData.push({
                    time_home: time_home,
                    time_away: time_away,
                    home_home_wins: homeHomeWins,
                    home_away_wins: homeAwayWins,
                    away_home_wins: awayHomeWins,
                    away_away_wins: awayAwayWins,    
                    total_home_wins: homeHomeWins + homeAwayWins,
                    total_away_wins: awayHomeWins + awayAwayWins,
                    total_home_general_wins: homeTotalHomeWins,
                    total_away_general_wins: awayTotalAwayWins,
                    home_win_percentage: homeWinPercentage,
                    away_win_percentage: awayWinPercentage,
                    total_home_games: homeIds.length,
                    total_away_games: awayIds.length,
                    total_home_Average_Points: homeAveragePoints,
                    total_away_Average_Points: awayAveragePoints,
                    total_media_Average_Points: totalAveragePoints.toFixed(2),
                });
            } catch (innerError) {
                console.error(`Erro ao processar os times ${time_home} e ${time_away}:`, innerError);
            }
        }

        res.json(confrontationData);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).json({ error: 'Erro ao processar os dados' });
    }
});





app.get('/team-points-analysis', async (req, res) => {
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            // Verificar tabelas existentes
            const tablesResult = await pool.query(`
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_name = $1 OR table_name = $2
            `, [homeTable, awayTable]);

            const tableNames = tablesResult.rows.map(row => row.table_name);

            // Inicializar variáveis para os cálculos
            let homePointsMadeAtHome = 0;
            let homePointsConcededAtHome = 0;
            let homePointsMadeAway = 0;
            let homePointsConcededAway = 0;

            let awayPointsMadeAtHome = 0;
            let awayPointsConcededAtHome = 0;
            let awayPointsMadeAway = 0;
            let awayPointsConcededAway = 0;

            let homeGamesAtHome = 0;
            let homeGamesAway = 0;
            let awayGamesAtHome = 0;
            let awayGamesAway = 0;

            // Pontos do time da casa (jogando em casa)
            if (tableNames.includes(homeTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT home_score, away_score
                    FROM ${homeTable} 
                    WHERE home_team = $1
                    ORDER BY id ASC
                `, [time_home]);

                homeScoresResult.rows.forEach(row => {
                    homePointsMadeAtHome += parseInt(row.home_score, 10) || 0;
                    homePointsConcededAtHome += parseInt(row.away_score, 10) || 0;
                });
                homeGamesAtHome = homeScoresResult.rows.length;
            }

            // Pontos do time da casa (jogando fora)
            if (tableNames.includes(homeTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT home_score, away_score
                    FROM ${homeTable} 
                    WHERE away_team = $1
                    ORDER BY id ASC
                `, [time_home]);

                awayScoresResult.rows.forEach(row => {
                    homePointsMadeAway += parseInt(row.away_score, 10) || 0;
                    homePointsConcededAway += parseInt(row.home_score, 10) || 0;
                });
                homeGamesAway = awayScoresResult.rows.length;
            }

            // Pontos do time visitante (jogando em casa)
            if (tableNames.includes(awayTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT home_score, away_score
                    FROM ${awayTable} 
                    WHERE home_team = $1
                    ORDER BY id ASC
                `, [time_away]);

                homeScoresResult.rows.forEach(row => {
                    awayPointsMadeAtHome += parseInt(row.home_score, 10) || 0;
                    awayPointsConcededAtHome += parseInt(row.away_score, 10) || 0;
                });
                awayGamesAtHome = homeScoresResult.rows.length;
            }

            // Pontos do time visitante (jogando fora)
            if (tableNames.includes(awayTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT home_score, away_score
                    FROM ${awayTable} 
                    WHERE away_team = $1
                    ORDER BY id ASC
                `, [time_away]);

                awayScoresResult.rows.forEach(row => {
                    awayPointsMadeAway += parseInt(row.away_score, 10) || 0;
                    awayPointsConcededAway += parseInt(row.home_score, 10) || 0;
                });
                awayGamesAway = awayScoresResult.rows.length;
            }

            // Cálculos finais para o time da casa
            const homeTotalGames = homeGamesAtHome + homeGamesAway;
            const homeTotalPointsMade = homePointsMadeAtHome + homePointsMadeAway;
            const homeTotalPointsConceded = homePointsConcededAtHome + homePointsConcededAway;
            const homeAveragePointsMade = homeTotalGames ? (homeTotalPointsMade / homeTotalGames).toFixed(2) : 0;
            const homeAveragePointsConceded = homeTotalGames ? (homeTotalPointsConceded / homeTotalGames).toFixed(2) : 0;
            const homeClassification = homeAveragePointsMade > homeAveragePointsConceded ? 'Ofensivo' : 'Defensivo';

            // Cálculos finais para o time visitante
            const awayTotalGames = awayGamesAtHome + awayGamesAway;
            const awayTotalPointsMade = awayPointsMadeAtHome + awayPointsMadeAway;
            const awayTotalPointsConceded = awayPointsConcededAtHome + awayPointsConcededAway;
            const awayAveragePointsMade = awayTotalGames ? (awayTotalPointsMade / awayTotalGames).toFixed(2) : 0;
            const awayAveragePointsConceded = awayTotalGames ? (awayTotalPointsConceded / awayTotalGames).toFixed(2) : 0;
            const awayClassification = awayAveragePointsMade > awayAveragePointsConceded ? 'Ofensivo' : 'Defensivo';

            results.push({
                time_home,
                home_points_made_at_home: homePointsMadeAtHome,
                home_points_conceded_at_home: homePointsConcededAtHome,
                home_points_made_away: homePointsMadeAway,
                home_points_conceded_away: homePointsConcededAway,
                home_total_points_made: homeTotalPointsMade,
                home_total_points_conceded: homeTotalPointsConceded,
                home_average_points_made: homeAveragePointsMade,
                home_average_points_conceded: homeAveragePointsConceded,
                home_classification: homeClassification,

                time_away,
                away_points_made_at_home: awayPointsMadeAtHome,
                away_points_conceded_at_home: awayPointsConcededAtHome,
                away_points_made_away: awayPointsMadeAway,
                away_points_conceded_away: awayPointsConcededAway,
                away_total_points_made: awayTotalPointsMade,
                away_total_points_conceded: awayTotalPointsConceded,
                away_average_points_made: awayAveragePointsMade,
                away_average_points_conceded: awayAveragePointsConceded,
                away_classification: awayClassification,
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/over-odds-analysis', async (req, res) => {
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away, over_odds FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        console.log(`Total de Vitoria Casa: ${results} `);

        for (const { time_home, time_away, over_odds } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

                // Buscar IDs do time da casa
                const homeIdsResult = await pool.query(`
                    SELECT id
                    FROM ${homeTable}
                    WHERE home_team = $1
                `, [time_home]);
                const homeIds = homeIdsResult.rows.map(row => row.id);

                console.log(`IDs extraídos para o time ${time_home}:`, homeIds);
                console.log(`Total de IDs para o time ${time_home}: ${homeIds.length}`);

                // Buscar IDs do time visitante
                const awayIdsResult = await pool.query(`
                    SELECT id
                    FROM ${awayTable}
                    WHERE away_team = $1
                `, [time_away]);
                const awayIds = awayIdsResult.rows.map(row => row.id);

                console.log(`IDs extraídos para o time ${time_away}:`, awayIds);
                console.log(`Total de IDs para o time ${time_away}: ${awayIds.length}`);

            const overThreshold = over_odds / 2; // Dividir o overOdds por 2

            // Inicializar contadores
            let homeExceedCount = 0;
            let awayExceedCount = 0;

            // Verificar se as tabelas existem
            const tablesResult = await pool.query(`
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_name = $1 OR table_name = $2
            `, [homeTable, awayTable]);

            const tableNames = tablesResult.rows.map(row => row.table_name);

            // Verificar pontos do time_home jogando em casa
            if (tableNames.includes(homeTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT home_score
                    FROM ${homeTable}
                    WHERE home_team = $1
                    ORDER BY id ASC
                `, [time_home]);

                // Contar quantas vezes o time_home fez mais que o limite
                homeScoresResult.rows.forEach(row => {
                    if (parseInt(row.home_score, 10) > overThreshold) {
                        homeExceedCount++;
                    }
                });
            }

            // Verificar pontos do time_away jogando fora
            if (tableNames.includes(awayTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT away_score
                    FROM ${awayTable}
                    WHERE away_team = $1
                    ORDER BY id ASC
                `, [time_away]);

                // Contar quantas vezes o time_away fez mais que o limite
                awayScoresResult.rows.forEach(row => {
                    if (parseInt(row.away_score, 10) > overThreshold) {
                        awayExceedCount++;
                    }
                });
            }
             // Calcular a porcentagem
             const totalExceeds = homeExceedCount + awayExceedCount;
             const totalGames = homeIds.length + awayIds.length;
             const percentage = totalGames > 0 ? ((totalExceeds / totalGames) * 100).toFixed(2) : 0;
 

            // Adicionar os resultados para o confronto atual
            results.push({
                time_home, // Nome do time da casa
                time_away, // Nome do time visitante
                overThreshold, // Valor de over_odds dividido por 2
                homeExceedCount, // Quantidade de vezes que o time da casa superou o limite
                awayExceedCount, // Quantidade de vezes que o time visitante superou o limite
                homeIdCount: homeIds.length, // Total de IDs encontrados para o time da casa
                awayIdCount: awayIds.length, // Total de IDs encontrados para o time visitante
                percentage
            });
            
        }

        // Enviar os resultados como JSON
        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


// Endpoint para buscar os dados da tabela nba_classificacao
app.get('/odds-nba', async (req, res) => {
    try {
      // Busca os dados da tabela "odds"
      const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
      const oddsRows = oddsResult.rows;
  
      const results = [];
  
      for (const { time_home, time_away } of oddsRows) {
        // Busca o rank do time da casa
        const homeClassificationResult = await pool.query(`
          SELECT rank 
          FROM nba_classificacao 
          WHERE team_name = $1
        `, [time_home]);
  
        const homeRank = homeClassificationResult.rows[0]?.rank || 'N/A'; // Rank do time da casa
  
        // Busca o rank do time visitante
        const awayClassificationResult = await pool.query(`
          SELECT rank 
          FROM nba_classificacao 
          WHERE team_name = $1
        `, [time_away]);
  
        const awayRank = awayClassificationResult.rows[0]?.rank || 'N/A'; // Rank do time visitante
  
        // Adiciona os dados ao resultado final
        results.push({
          time_home,
          time_away,
          home_classification: homeRank, // Rank do time da casa
          away_classification: awayRank, // Rank do time visitante
        });
      }
  
      res.json(results);
    } catch (error) {
      console.error('Erro ao buscar dados da NBA:', error);
      res.status(500).json({ error: 'Erro ao buscar dados' });
    }
  });
  

// Servir arquivos estáticos da pasta 'public'
app.use(express.static(path.join(__dirname, 'public')));

// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}/`);
});
