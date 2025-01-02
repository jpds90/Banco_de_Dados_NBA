const { Pool } = require('pg');

// Configuração do banco de dados
const pool = new Pool({
    user: 'admin',
    host: 'localhost',
    database: 'nba',
    password: '123456',
    port: 5432,
});

(async () => {
    try {
        // Buscar os dados da tabela odds
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        for (const { time_home, time_away } of oddsRows) {
            // Gerar nomes de tabelas com base nos times
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            console.log(`Processando os times: Home - ${time_home}, Away - ${time_away}`);
            console.log(`Tabelas esperadas: ${homeTable}, ${awayTable}`);

            // Verificar se as tabelas existem no banco de dados
            const tablesResult = await pool.query(`
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_name = $1 OR table_name = $2
            `, [homeTable, awayTable]);

            const tableNames = tablesResult.rows.map(row => row.table_name);

            console.log(`Tabelas encontradas: ${tableNames.join(', ')}`);

            // Processar dados do Time Home
            if (tableNames.includes(homeTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT home_score 
                    FROM ${homeTable} 
                    WHERE home_team = $1
                    ORDER BY id ASC
                    LIMIT 12
                `, [time_home]);

                console.log(`Dados encontrados para o time da casa (${time_home}):`, homeScoresResult.rows);

                const homeScores = homeScoresResult.rows
                    .map(row => parseInt(row.home_score, 10))
                    .filter(score => !isNaN(score));

                console.log(`Scores do Time Home (${time_home}):`, homeScores);

                const homeAvg = homeScores.length 
                    ? (homeScores.reduce((a, b) => a + b, 0) / homeScores.length).toFixed(2) 
                    : 0;

                console.log(`Média dos últimos 12 jogos em casa (Home - ${time_home}): ${homeAvg}`);
            } else {
                console.log(`Tabela para ${time_home} não encontrada.`);
            }

            // Processar dados do Time Away
            if (tableNames.includes(awayTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT away_score 
                    FROM ${awayTable} 
                    WHERE away_team = $1
                    ORDER BY id ASC
                    LIMIT 12
                `, [time_away]);

                console.log(`Dados encontrados para o time visitante (${time_away}):`, awayScoresResult.rows);

                const awayScores = awayScoresResult.rows
                    .map(row => parseInt(row.away_score, 10))
                    .filter(score => !isNaN(score));

                console.log(`Scores do Time Away (${time_away}):`, awayScores);

                const awayAvg = awayScores.length 
                    ? (awayScores.reduce((a, b) => a + b, 0) / awayScores.length).toFixed(2) 
                    : 0;

                console.log(`Média dos últimos 12 jogos fora de casa (Away - ${time_away}): ${awayAvg}`);
            } else {
                console.log(`Tabela para ${time_away} não encontrada.`);
            }
        }
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
    } finally {
        await pool.end();
    }
})();
