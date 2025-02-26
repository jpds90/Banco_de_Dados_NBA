const express = require('express');
const { Pool } = require('pg');
const path = require('path');
const { exec } = require('child_process');
const fs = require('fs');
const { scrapeResults } = require('./script');
const { scrapeResults1 } = require('./jogadores');
const { fetchLinksFromDatabase1 } = require('./futebol');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');
const cors = require('cors');
const { scrapeResults3 } = require('./lesoes');
const { scrapeResults10 } = require('./futebol');

const app = express();
// Configuração da porta para Render (usa a variável PORT ou padrão 3000)
const port = process.env.PORT || 3000;



// Configuração do pool de conexão com o banco de dados
const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // Usando a URL completa do Render
  ssl: { rejectUnauthorized: false }, // Necessário para conexões seguras
});
// Função para gerar um novo token
function generateToken(userId, email) {
    const payload = { userId, email };
    const secretKey = 'seu-segredo-aqui'; // Substitua pela sua chave secreta
    const options = { expiresIn: '10000000h' }; // Define o tempo de expiração do token (exemplo: 1 hora)
    return jwt.sign(payload, secretKey, options);
}

// Middleware para processar JSON
app.use(express.json()); // Aqui processamos JSON no corpo da requisição
app.use(express.urlencoded({ extended: true })); // Opcional, para processar dados URL-encoded


app.use(cors({ origin: 'https://analise-jpnba.onrender.com' }));

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


// ✅ Criar a tabela automaticamente se não existir
const ensureTableExists = async (tableName) => {
    const client = await pool.connect();
    try {
        await client.query(`
            CREATE TABLE IF NOT EXISTS ${tableName} (
                id SERIAL PRIMARY KEY,
                link TEXT NOT NULL
            )
        `);
        console.log(`✅ Tabela ${tableName} verificada/criada.`);
    } catch (error) {
        console.error(`❌ Erro ao criar/verificar a tabela ${tableName}:`, error);
    } finally {
        client.release();
    }
};
// Endpoint para receber a URL do frontend
app.post("/salvar-url", async (req, res) => {
    const { url, tableName } = req.body;

    if (!url || !tableName) {
        return res.status(400).json({ success: false, message: "URL ou tableName ausente" });
    }

    // ✅ Garante que a tabela existe antes de inserir
    await ensureTableExists(tableName);

    const client = await pool.connect();
    try {
        // 🔎 Verifica se a URL já existe
        const checkExistence = await client.query(`SELECT * FROM ${tableName} WHERE link = $1`, [url]);

        if (checkExistence.rows.length > 0) {
            console.log(`🔄 URL já existe na tabela ${tableName}: ${url}`);
            return res.json({ success: false, message: "URL já está salva!" });
        }

        // 💾 Insere a URL se ainda não existir
        await client.query(`INSERT INTO ${tableName} (link) VALUES ($1)`, [url]);
        console.log(`✅ URL salva na tabela ${tableName}: ${url}`);

        res.json({ success: true, message: "URL salva com sucesso!" });
    } catch (error) {
        console.error("❌ Erro ao salvar URL:", error);
        res.status(500).json({ success: false, message: "Erro ao salvar URL." });
    } finally {
        client.release();
    }
});


//Futebol------------------Futebol------------futebol------------------------

// ✅ Função para buscar dados da tabela no banco de dados
const fetchLinksFromDatabase = async (tableName) => {
    const client = await pool.connect();
    try {
        console.log(`🔍 Buscando dados na tabela: ${tableName}...`);
        // Seleciona as colunas team_name, link e event_time
        const result = await client.query(`SELECT team_name, link, event_time FROM ${tableName}`);

        if (result.rows.length > 0) {
            console.log(`✅ ${result.rows.length} registros encontrados.`);
            // Retorna o array de objetos com team_name, link e event_time
            return result.rows;
        } else {
            console.log("⚠️ Nenhum registro encontrado.");
            return [];
        }
    } catch (error) {
        console.error(`❌ Erro ao buscar dados na tabela ${tableName}:`, error);
        return [];
    } finally {
        client.release();
    }
};



// Rota para executar o script futebol link.js
app.post('/futebollink', (req, res) => {
    const { tableName } = req.body;  // Recebe o nome da tabela do frontend
     console.log("🔹 Recebendo request em /futebollink com tableName:", tableName);
    if (!tableName) {
        return res.status(400).json({ success: false, message: "tableName ausente" });
    }

    const scriptPath = path.join(__dirname, 'public', 'linksfutebol.js');
    console.log(`📂 Caminho do script URL dos Times: ${scriptPath}`);
    runScript(scriptPath, res, 'Extrair URL dos Times', [tableName]);
});



app.post('/timefutebol', async (req, res) => {
    const { tableName } = req.body;
    console.log(`🔍 Recebido Futebol.js: ${tableName}`);

    try {
        const links = await fetchLinksFromDatabase1(tableName);

        console.log("📤 Enviando links para o frontend do Fuetbol.js:", links);  // 🔥 Adicione isso

        res.json(links);
    } catch (error) {
        console.error("❌ Erro ao buscar links:", error);
        res.status(500).send('Erro ao buscar os links');
    }
});


// Rota para executar o script oddsfutebol.js
app.post('/oddsfutebol', (req, res) => {
    const { tableName } = req.body;  // Recebe o nome da tabela do frontend
     console.log("🔹 Recebendo request em /oddsfutebol com tableName:", tableName);
    if (!tableName) {
        return res.status(400).json({ success: false, message: "tableName ausente" });
    }

    const scriptPath = path.join(__dirname, 'public', 'oddsfutebol.js');
    console.log(`📂 Caminho do script do Odds: ${scriptPath}`);
    runScript(scriptPath, res, 'Extrair odds dos Times', [tableName]);
});





// Buscar dados para Futebol
app.get("/buscar-times", async (req, res) => {
  const { tableName } = req.query;
  if (!tableName) {
    return res.status(400).json({ success: false, message: "tableName não fornecido!" });
  }

  try {
    const query = `SELECT data_jogo, time_home, time_away FROM ${tableName}`;
    const { rows } = await pool.query(query); // ALTERADO DE db.query PARA pool.query
    return res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Erro ao buscar os times:", error);
    return res.status(500).json({ success: false, message: "Erro ao buscar os times." });
  }
});






app.get('/probabilidade', async (req, res) => {
    try {
        const { timeHome, timeAway } = req.query;

        if (!timeHome || !timeAway) {
            return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
        }

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

        const queryStats = async (table) => {
            const result = await pool.query(`
                SELECT 
                    AVG(golos_esperados_xg) AS xg, 
                    AVG(posse_de_bola) AS posse,
                    AVG(tentativas_de_golo) AS finalizacoes,
                    AVG(remates_a_baliza) AS remates,
                    AVG(grandes_oportunidades) AS oportunidades,
                    AVG(defesas_de_guarda_redes) AS defesas,
                    AVG(desarmes + intercepcoes) AS defesa
                FROM ${table}
            `);
            return result.rows[0];
        };

        const homeStats = await queryStats(homeTable);
        const awayStats = await queryStats(awayTable);

        const calculateWinProbability = (home, away) => {
            const weights = {
                xg: 0.25, 
                posse: 0.15, 
                finalizacoes: 0.15,
                remates: 0.15, 
                oportunidades: 0.20, 
                defesas: -0.10, 
                defesa: 0.10
            };

            let homeScore = 0;
            let awayScore = 0;

            for (const key in weights) {
                homeScore += (home[key] || 0) * weights[key];
                awayScore += (away[key] || 0) * weights[key];
            }

            // Vantagem do time da casa (adicionando +7%)
            const homeAdvantage = 0.07; 
            homeScore *= (1 + homeAdvantage); 

            const total = homeScore + awayScore;
            const homeWinProb = ((homeScore / total) * 100).toFixed(2);
            const awayWinProb = ((awayScore / total) * 100).toFixed(2);

            return { homeWinProb, awayWinProb };
        };

        const probabilities = calculateWinProbability(homeStats, awayStats);

        res.json({
            time_home: timeHome,
            home_win_probability: probabilities.homeWinProb,
            time_away: timeAway,
            away_win_probability: probabilities.awayWinProb,
            advantage_home: "+7% Vantagem psicológica e adaptação ao campo"
        });
    } catch (error) {
        console.error("Erro ao calcular probabilidades:", error);
        res.status(500).json({ error: "Erro interno do servidor" });
    }
});


app.get('/golssofrido',  async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       function normalizarNomeTime(nome) {
           return nome
               .toLowerCase()
               .normalize("NFD")
               .replace(/[\u0300-\u036f]/g, '') // Remove acentos
               .replace(/[\s\-]/g, '') // Remove espaços e hífens
               .replace(/\./g, '') // Remove pontos
               .trim(); 
       }

       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa: ${timeHome} (Normalizado: ${timeHomeNormalizado})`);
       console.log(`📌 Time visitante: ${timeAway} (Normalizado: ${timeAwayNormalizado})`);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Tabela timeHome: ${homeTable}`);
       console.log(`📌 Tabela timeAway: ${awayTable}`);

       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`,
           [homeTable, awayTable]
       );

       console.log("🔎 Tabelas encontradas:", tablesResult.rows);

       let homeGoals = [];
       let awayGoals = [];

       if (tablesResult.rows.some(row => row.table_name === homeTable)) {
           console.log(`📄 Buscando jogos de ${timeHome} como mandante na tabela: ${homeTable}`);

           const homeScoresResult = await pool.query(`
               SELECT resultadoaway 
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHome]);

           console.log("📊 Resultados timeHome (como mandante):", homeScoresResult.rows);

           homeGoals = homeScoresResult.rows
               .map(row => parseInt(row.resultadoaway, 10))
               .filter(score => !isNaN(score));
       }

       if (tablesResult.rows.some(row => row.table_name === awayTable)) {
           console.log(`📄 Buscando jogos de ${timeAway} como visitante na tabela: ${awayTable}`);

           const awayScoresResult = await pool.query(`
               SELECT resultadohome 
               FROM ${awayTable} 
               WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAway]);

           console.log("📊 Resultados timeAway (como visitante):", awayScoresResult.rows);

           awayGoals = awayScoresResult.rows
               .map(row => parseInt(row.resultadohome, 10))
               .filter(score => !isNaN(score));
       }

       const homeAvg = homeGoals.length ? (homeGoals.reduce((a, b) => a + b, 0) / homeGoals.length).toFixed(2) : 0;
       const awayAvg = awayGoals.length ? (awayGoals.reduce((a, b) => a + b, 0) / awayGoals.length).toFixed(2) : 0;

       console.log("✅ Resumo final:", {
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg
       });

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg
       });

   } catch (error) {
       console.error('❌ Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});



app.get('/golsfeito', async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       function normalizarNomeTime(nome) {
           return nome
               .toLowerCase()
               .normalize("NFD")
               .replace(/[\u0300-\u036f]/g, '') // Remove acentos
               .replace(/[\s\-]/g, '') // Remove espaços e hífens
               .replace(/\./g, '') // Remove pontos
               .trim(); 
       }

       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa: ${timeHome} (Normalizado: ${timeHomeNormalizado})`);
       console.log(`📌 Time visitante: ${timeAway} (Normalizado: ${timeAwayNormalizado})`);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Tabela timeHome: ${homeTable}`);
       console.log(`📌 Tabela timeAway: ${awayTable}`);

       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`,
           [homeTable, awayTable]
       );

       console.log("🔎 Tabelas encontradas:", tablesResult.rows);

       let homeGoals = [];
       let awayGoals = [];

       if (tablesResult.rows.some(row => row.table_name === homeTable)) {
           console.log(`📄 Buscando jogos de ${timeHome} como mandante na tabela: ${homeTable}`);

           const homeScoresResult = await pool.query(`
               SELECT resultadohome 
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHome]);

           console.log("📊 Resultados timeHome (como mandante):", homeScoresResult.rows);

           homeGoals = homeScoresResult.rows
               .map(row => parseInt(row.resultadohome, 10))
               .filter(score => !isNaN(score));
       }

       if (tablesResult.rows.some(row => row.table_name === awayTable)) {
           console.log(`📄 Buscando jogos de ${timeAway} como visitante na tabela: ${awayTable}`);

           const awayScoresResult = await pool.query(`
               SELECT resultadoaway 
               FROM ${awayTable} 
               WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAway]);

           console.log("📊 Resultados timeAway (como visitante):", awayScoresResult.rows);

           awayGoals = awayScoresResult.rows
               .map(row => parseInt(row.resultadoaway, 10))
               .filter(score => !isNaN(score));
       }

       const homeAvg = homeGoals.length ? (homeGoals.reduce((a, b) => a + b, 0) / homeGoals.length).toFixed(2) : 0;
       homeHitsThreshold = homeGoals.length;
       const awayAvg = awayGoals.length ? (awayGoals.reduce((a, b) => a + b, 0) / awayGoals.length).toFixed(2) : 0;
       awayHitsThreshold = awayGoals.length;
     
       console.log("✅ Resumo final:", {
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

   } catch (error) {
       console.error('❌ Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});



app.get('/golsemcasa', async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
       function normalizarNomeTime(nome) {
           return nome
               .toLowerCase()
               .normalize("NFD")
               .replace(/[\u0300-\u036f]/g, '') // Remove acentos
               .replace(/[\s\-]/g, '') // Remove espaços e hífens
               .replace(/\./g, '') // Remove pontos
               .trim(); 
       }

       // 🔄 Normalizando os nomes dos times
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa recebido: ${timeHome} (Normalizado: ${timeHomeNormalizado})`);
       console.log(`📌 Time visitante recebido: ${timeAway} (Normalizado: ${timeAwayNormalizado})`);

       // 🔍 Gerando nomes das tabelas
       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Tabela do time da casa: ${homeTable}`);
       console.log(`📌 Tabela do time visitante: ${awayTable}`);

       // 🔎 Verificando se as tabelas existem no banco de dados
       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`,
           [homeTable, awayTable]
       );

       console.log("🔎 Tabelas encontradas:", tablesResult.rows);

       const tableNames = tablesResult.rows.map(row => row.table_name);
       let homeHitsThreshold = 0;
       let awayHitsThreshold = 0;
       let homeAvg = 0;
       let awayAvg = 0;

       if (tableNames.includes(homeTable)) {
           console.log(`📄 Consultando dados para a tabela: ${homeTable}`);
           const homeScoresResult = await pool.query(`
               SELECT timehome, resultadohome
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1) OR unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY data_hora DESC
               LIMIT 10
           `, [timeHome]);

           console.log("📊 Resultados do time da casa:", homeScoresResult.rows);

           if (homeScoresResult.rows.length === 0) {
               console.log("🔴 Nenhum resultado encontrado para:", timeHome);
           } else {
               console.log("🟢 Resultados encontrados:", homeScoresResult.rows);
           }

           // 🔄 Filtrando apenas jogos válidos e calculando média
           const homeScores = homeScoresResult.rows
               .filter(row =>
                   normalizarNomeTime(row.timehome) === timeHomeNormalizado 
               )
               .map(row => parseInt(row.resultadohome, 10))
               .filter(score => !isNaN(score) && score > threshold);

           homeAvg = homeScores.length ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) : 0;
           homeHitsThreshold = homeScores.length;
       }

       if (tableNames.includes(awayTable)) {
           console.log(`📄 Consultando dados para a tabela: ${awayTable}`);
           const awayScoresResult = await pool.query(`
               SELECT timeaway, resultadoaway 
               FROM ${awayTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1) OR unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY data_hora DESC
               LIMIT 10
           `, [timeAway]);

           console.log("📊 Resultados do time visitante:", awayScoresResult.rows);

           if (awayScoresResult.rows.length === 0) {
               console.log("🔴 Nenhum resultado encontrado para:", timeAway);
           } else {
               console.log("🟢 Resultados encontrados:", awayScoresResult.rows);
           }

           // 🔄 Filtrando apenas jogos válidos e calculando média
           const awayScores = awayScoresResult.rows
               .filter(row =>
                   normalizarNomeTime(row.timeaway) === timeAwayNormalizado
               )
               .map(row => parseInt(row.resultadoaway, 10))
               .filter(score => !isNaN(score) && score > threshold);

           awayAvg = awayScores.length ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) : 0;
           awayHitsThreshold = awayScores.length;
       }

       console.log("✅ Resumo final:", {
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

   } catch (error) {
       console.error('❌ Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});


app.get('/golsemcasa2', async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;
      console.log(`📌 time da casa: ${timeHome} (tipo: ${typeof timeHome})`);
      console.log(`📌 time visitante: ${timeAway} (tipo: ${typeof timeAway})`);

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim(); 
}


       // 🔄 Normaliza os nomes dos times da requisição
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa recebido (normalizado): ${timeHomeNormalizado}`);
       console.log(`📌 Time visitante recebido (normalizado): ${timeAwayNormalizado}`);
       console.log(`🔍 Filtro de gol: ${threshold}`);

       // 📌 Criar os nomes das tabelas SEM normalizar (mantendo o formato correto do banco)
       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Tabela do time da casa: ${homeTable}`);
       console.log(`📌 Tabela do time visitante: ${awayTable}`);

       // Verificar se as tabelas existem
       const tablesResult = await pool.query(`
           SELECT table_name 
           FROM information_schema.tables 
           WHERE table_name = $1 OR table_name = $2
       `, [homeTable, awayTable]);

       const tableNames = tablesResult.rows.map(row => row.table_name);
       let homeHitsThreshold = 0;
       let awayHitsThreshold = 0;
       let homeAvg = 0;
       let awayAvg = 0;

       // Verificar e calcular os gols em casa
       if (tableNames.includes(homeTable)) {
           const homeScoresResult = await pool.query(`
               SELECT timehome, resultadohome
               FROM ${homeTable} 
                WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHomeNormalizado]);
         
       console.log(`📄 Executando query para: ${homeScoresResult}`);
// Verifica se encontrou resultados
if (homeScoresResult.rows.length === 0) {
    console.log("🔴 Nenhum resultado encontrado para:", timeHomeNormalizado);
} else {
    console.log("🟢 Encontrado!", homeScoresResult.rows);
}
const homeScores = homeScoresResult.rows
    .filter(row => normalizarNomeTime(row.timehome).localeCompare(timeHomeNormalizado, undefined, { sensitivity: 'base' }) === 0)
    .map(row => parseInt(row.resultadohome, 10))
    .filter(score => !isNaN(score) && score > threshold);


           homeAvg = homeScores.length ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) : 0;
           homeHitsThreshold = homeScores.length;
       }

       // Verificar e calcular os gols fora de casa
       if (tableNames.includes(awayTable)) {
           const awayScoresResult = await pool.query(`
               SELECT resultadoaway, timeaway 
               FROM ${awayTable} 
                WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAwayNormalizado]);
         
       console.log(`📄 Executando query para : ${awayScoresResult}`);
// Verifica se encontrou resultados
if (awayScoresResult.rows.length === 0) {
    console.log("🔴 Nenhum resultado encontrado para:", timeAwayNormalizado);
} else {
    console.log("🟢 Encontrado!", awayScoresResult.rows);
}
const awayScores = awayScoresResult.rows
    .filter(row => 
        normalizarNomeTime(row.timeaway).localeCompare(timeAwayNormalizado, undefined, { sensitivity: 'base' }) === 0
    )
    .map(row => parseInt(row.resultadoaway, 10))
    .filter(score => !isNaN(score) && score > threshold);


           awayAvg = awayScores.length ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) : 0;
           awayHitsThreshold = awayScores.length;
       }

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

   } catch (error) {
       console.error('Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});


app.get('/ambasmarcam', async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       function normalizarNomeTime(nome) {
           return nome
               .toLowerCase()
               .normalize("NFD")
               .replace(/[\u0300-\u036f]/g, '') // Remove acentos
               .replace(/[\s\-]/g, '') // Remove espaços e hífens
               .replace(/\./g, '') // Remove pontos
               .trim(); 
       }

       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa: ${timeHome} (Normalizado: ${timeHomeNormalizado})`);
       console.log(`📌 Time visitante: ${timeAway} (Normalizado: ${timeAwayNormalizado})`);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Tabela timeHome: ${homeTable}`);
       console.log(`📌 Tabela timeAway: ${awayTable}`);

       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`,
           [homeTable, awayTable]
       );

       console.log("🔎 Tabelas encontradas:", tablesResult.rows);

       let homeGoals = [];
       let awayGoals = [];

       if (tablesResult.rows.some(row => row.table_name === homeTable)) {
           console.log(`📄 Buscando jogos de ${timeHome} como mandante na tabela: ${homeTable}`);

           const homeScoresResult = await pool.query(`
               SELECT resultadohome 
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHome]);

           console.log("📊 Resultados timeHome (como mandante):", homeScoresResult.rows);

           homeGoals = homeScoresResult.rows.filter(row => parseInt(row.resultadohome, 10) > 0).length;
       }

       if (tablesResult.rows.some(row => row.table_name === awayTable)) {
           console.log(`📄 Buscando jogos de ${timeAway} como visitante na tabela: ${awayTable}`);

           const awayScoresResult = await pool.query(`
               SELECT resultadoaway 
               FROM ${awayTable} 
               WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAway]);

           console.log("📊 Resultados timeAway (como visitante):", awayScoresResult.rows);

           awayGoals = awayScoresResult.rows.filter(row => parseInt(row.resultadoaway, 10) > 0).length;
       }


       console.log("✅ Resumo final:", {
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeGoals,
           away_avg: awayGoals,
           total_pontos: homeGoals + awayGoals
       });

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeGoals,
           away_avg: awayGoals,
           total_pontos: homeGoals + awayGoals
       });

   } catch (error) {
       console.error('❌ Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});

app.get('/ambas', async (req, res) => {
   try {
       const { timeHome, timeAway } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       function normalizarNomeTime(nome) {
           return nome
               .toLowerCase()
               .normalize("NFD")
               .replace(/[\u0300-\u036f]/g, '') // Remove acentos
               .replace(/[\s\-]/g, '') // Remove espaços e hífens
               .replace(/\./g, '') // Remove pontos
               .trim(); 
       }

       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`,
           [homeTable, awayTable]
       );

       let homeGoals = 0;
       let awayGoals = 0;
       const totalJogos = 10; // Sempre considerando os últimos 10 jogos

       if (tablesResult.rows.some(row => row.table_name === homeTable)) {
           const homeScoresResult = await pool.query(`
               SELECT resultadohome 
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHome]);

           homeGoals = homeScoresResult.rows.filter(row => parseInt(row.resultadohome, 10) > 0).length;
       }

       if (tablesResult.rows.some(row => row.table_name === awayTable)) {
           const awayScoresResult = await pool.query(`
               SELECT resultadoaway 
               FROM ${awayTable} 
               WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAway]);

           awayGoals = awayScoresResult.rows.filter(row => parseInt(row.resultadoaway, 10) > 0).length;
       }

       // Calcula a porcentagem dos jogos em que ambos marcaram
       const totalPontos = homeGoals + awayGoals;
       const porcentagem = (totalPontos / (totalJogos * 2)) * 100;

       let status;
       if (porcentagem >= 75) {
           status = "Ambas Marcam";
       } else if (porcentagem >= 65) {
           status = "+1,5 Gols";
       } else {
           status = "Nenhuma tendência forte";
       }

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_gols_marcados: homeGoals,
           away_gols_marcados: awayGoals,
           total_pontos: totalPontos,
           porcentagem: porcentagem.toFixed(2) + "%",
           status: status
       });

   } catch (error) {
       console.error('❌ Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});



app.get('/golsemcasa20', async (req, res) => {
    try {
        const { timeHome, timeAway, threshold = 0.5 } = req.query;

        if (!timeHome || !timeAway) {
            return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
        }

        // 🔄 Função para normalizar os nomes dos times
        function normalizarNomeTime(nome) {
            return nome
                .toLowerCase()
                .normalize("NFD")
                .replace(/[\u0300-\u036f]/g, '') // Remove acentos
                .replace(/[\s\-]/g, '') // Remove espaços e hífens
                .replace(/\./g, '') // Remove pontos
                .trim();
        }

        // 🔄 Normaliza os nomes dos times da requisição
        const timeHomeNormalizado = normalizarNomeTime(timeHome);
        const timeAwayNormalizado = normalizarNomeTime(timeAway);

        console.log(`📌 Time da casa recebido: ${timeHome}`);
        console.log(`📌 Time visitante recebido: ${timeAway}`);
        console.log(`🔍 Filtro de gol: ${threshold}`);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

        console.log(`📌 Tabela do time da casa: ${homeTable}`);
        console.log(`📌 Tabela do time visitante: ${awayTable}`);

        // Consultar as tabelas existentes
        const tablesResult = await pool.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name = $1 OR table_name = $2
        `, [homeTable, awayTable]);

        const tableNames = tablesResult.rows.map(row => row.table_name);
        let homeHitsThreshold = 0;
        let awayHitsThreshold = 0;
        let homeAvg = 0;
        let awayAvg = 0;

        // 📌 Buscar média de gols em casa para o timeHome
        if (tableNames.includes(homeTable)) {
            const homeScoresResult = await pool.query(`
                SELECT resultadohome 
                FROM ${homeTable} 
                WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
            `, [timeHomeNormalizado]);

            const homeScores = homeScoresResult.rows
                .map(row => parseInt(row.resultadohome, 10))
                .filter(score => !isNaN(score) && score > threshold);

            homeAvg = homeScores.length ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) : 0;
            homeHitsThreshold = homeScores.length;

            console.log(`✅ Média de gols em casa (${timeHome}): ${homeAvg} (Baseado em ${homeHitsThreshold} jogos)`);
        }

        // 📌 Buscar média de gols fora para o timeAway
        if (tableNames.includes(awayTable)) {
            const awayScoresResult = await pool.query(`
                SELECT resultadoaway 
                FROM ${awayTable} 
                WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
            `, [timeAwayNormalizado]);

            const awayScores = awayScoresResult.rows
                .map(row => parseInt(row.resultadoaway, 10))
                .filter(score => !isNaN(score) && score > threshold);

            awayAvg = awayScores.length ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) : 0;
            awayHitsThreshold = awayScores.length;

            console.log(`✅ Média de gols fora (${timeAway}): ${awayAvg} (Baseado em ${awayHitsThreshold} jogos)`);
        }

        res.json({
            time_home: timeHome,
            time_away: timeAway,
            home_avg: homeAvg,
            away_avg: awayAvg,
            total_pontos: homeAvg + awayAvg,
            home_hits_threshold: homeHitsThreshold,
            away_hits_threshold: awayHitsThreshold
        });

    } catch (error) {
        console.error('🔥 Erro ao processar os dados:', error);
        res.status(500).json({ error: 'Erro no servidor' });
    }
});


app.get('/golsemcasacancelar', async (req, res) => {
   try {
       const { timeHome, timeAway, threshold = 0.5 } = req.query;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Os parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim(); 
}


       // 🔄 Normaliza os nomes dos times da requisição
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`📌 Time da casa recebido: ${timeHome}`);
       console.log(`📌 Time visitante recebido: ${timeAway}`);
       console.log(`🔍 Filtro de gol: ${threshold}`);

       const homeTable = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
       const awayTable = timeAway.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       console.log(`📌 Time da casa Futebol: ${homeTable}`);
       console.log(`📌 Time visitante Futebol: ${awayTable}`);
       // Verificar se as tabelas existem
       const tablesResult = await pool.query(`
           SELECT table_name 
           FROM information_schema.tables 
           WHERE table_name = $1 OR table_name = $2
       `, [homeTable, awayTable]);

       const tableNames = tablesResult.rows.map(row => row.table_name);
       let homeHitsThreshold = 0;
       let awayHitsThreshold = 0;
       let homeAvg = 0;
       let awayAvg = 0;

       // Verificar e calcular os gols em casa
       if (tableNames.includes(homeTable)) {
           const homeScoresResult = await pool.query(`
               SELECT resultadohome 
               FROM ${homeTable} 
               WHERE unaccent(timehome) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeHomeNormalizado]);

           const homeScores = homeScoresResult.rows
               .map(row => parseInt(row.resultadohome, 10))
               .filter(score => !isNaN(score) && score > threshold);

           homeAvg = homeScores.length ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) : 0;
           homeHitsThreshold = homeScores.length;
       }

       // Verificar e calcular os gols fora de casa
       if (tableNames.includes(awayTable)) {
           const awayScoresResult = await pool.query(`
               SELECT resultadoaway 
               FROM ${awayTable} 
               WHERE unaccent(timeaway) ILIKE unaccent($1)
               ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
               LIMIT 10
           `, [timeAwayNormalizado]);

           const awayScores = awayScoresResult.rows
               .map(row => parseInt(row.resultadoaway, 10))
               .filter(score => !isNaN(score) && score > threshold);

           awayAvg = awayScores.length ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) : 0;
           awayHitsThreshold = awayScores.length;
       }

       res.json({
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg,
           home_hits_threshold: homeHitsThreshold,
           away_hits_threshold: awayHitsThreshold
       });

   } catch (error) {
       console.error('Erro ao processar os dados:', error);
       res.status(500).json({ error: 'Erro no servidor' });
   }
});



// 🔹 Endpoint para buscar a média de gols dos dois times
app.get('/golsemcasa100000', async (req, res) => {
   try {
       const timeHome = req.query.timeHome;
       const timeAway = req.query.timeAway;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       console.log(`🏠 Time Home consultado: ${timeHome}`);
       console.log(`🚀 Time Away consultado: ${timeAway}`);

       // Buscar os jogos de ambos os times
       const jogosHome = await buscarJogos(timeHome);
       const jogosAway = await buscarJogos(timeAway);

       let totalHome = 0, totalAway = 0;

       jogosHome.forEach(jogo => totalHome += parseInt(jogo.resultadohome) || 0);
       jogosAway.forEach(jogo => totalAway += parseInt(jogo.resultadoaway) || 0);

       const homeAvg = jogosHome.length ? Math.round(totalHome / jogosHome.length) : 0;
       const awayAvg = jogosAway.length ? Math.round(totalAway / jogosAway.length) : 0;

       const response = {
           time_home: timeHome,
           time_away: timeAway,
           home_avg: homeAvg,
           away_avg: awayAvg,
           total_pontos: homeAvg + awayAvg
       };

       console.log("📊 Média de gols calculada:", response);
       res.json([response]);

   } catch (error) {
       console.error("🔥 Erro ao calcular a média de gols:", error);
       res.status(500).send("Erro no servidor");
   }
});

// 🔹 Endpoint para buscar confrontos diretos entre dois times
app.get('/confrontosfutebol1', async (req, res) => {
   try {
       const timeHome = req.query.timeHome;
       const timeAway = req.query.timeAway;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim(); 
}


       // 🔄 Normaliza os nomes dos times da requisição
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);
     
       console.log(`🏠 Time Home consultado: ${timeHome}`);
       console.log(`🚀 Time Away consultado: ${timeAway}`);

       const tableHome = timeHome.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

       // Verifica se a tabela existe no banco
       const tablesResult = await pool.query(
           `SELECT table_name FROM information_schema.tables WHERE table_name = $1`, 
           [tableHome]
       );

       if (tablesResult.rows.length === 0) {
           console.log("❌ Nenhuma tabela encontrada para os times informados.");
           return res.json([]);
       }

       // Busca os confrontos diretos
       const confrontationsQuery = `
           SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
           FROM ${tableHome} 
           WHERE (unaccent(timehome) ILIKE unaccent($1) AND unaccent(timeaway) ILIKE unaccent($2)) 
       OR (unaccent(timehome) ILIKE unaccent($2) AND unaccent(timeaway) ILIKE unaccent($1))
           ORDER BY 
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 1
                     ELSE 2
                 END,
                 CASE
                     WHEN data_hora LIKE '__.__. __:__' THEN 
                         TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                     WHEN data_hora LIKE '__.__.____ __:__' THEN 
                         TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
                 END DESC
           LIMIT 1000
       `;

       console.log(`📄 Executando query de confrontos diretos: ${confrontationsQuery}`);
       const confrontationsResult = await pool.query(confrontationsQuery, [timeHome, timeAway]);

       // Inicializa as variáveis para cálculo da média
       let totalHomePoints = 0;
       let totalAwayPoints = 0;
       let countGames = 0;

       // Processa os confrontos
       const response = confrontationsResult.rows.map(row => {
           const homePoints = row.resultadohome !== null ? parseInt(row.resultadohome, 10) : 0;
           const awayPoints = row.resultadoaway !== null ? parseInt(row.resultadoaway, 10) : 0;

           if (!isNaN(homePoints) && !isNaN(awayPoints)) {
               totalHomePoints += homePoints;
               totalAwayPoints += awayPoints;
               countGames++;
           }

           return {
               timehome: row.timehome,
               timeaway: row.timeaway,
               resultadohome: homePoints,
               resultadoaway: awayPoints,
               total_pontos: homePoints + awayPoints,
               data_hora: row.data_hora
           };
       });

       // Calcula as médias
       const homeAveragePoints = countGames > 0 ? (totalHomePoints / countGames).toFixed(2) : "0";
       const awayAveragePoints = countGames > 0 ? (totalAwayPoints / countGames).toFixed(2) : "0";
       const totalPoints = countGames > 0 ? ((totalHomePoints + totalAwayPoints) / countGames).toFixed(2) : "0";

       console.log("📊 Confrontos diretos encontrados:", response);
       console.log(`📢 Média de pontos - Home: ${homeAveragePoints}, Away: ${awayAveragePoints}, Total: ${totalPoints}`);

       res.json({
           confrontations: response,
           home_average_points: homeAveragePoints,
           away_average_points: awayAveragePoints,
           total_points: totalPoints
       });

   } catch (error) {
       console.error("🔥 Erro ao buscar confrontos diretos:", error);
       res.status(500).send("Erro no servidor");
   }
});




app.get("/ultimos10jogos", async (req, res) => {
   try {
       const timeHome = req.query.timeHome;
       const timeAway = req.query.timeAway;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim(); 
}


       // 🔄 Normaliza os nomes dos times da requisição
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`🏠 Time 1 consultado: ${timeHome}`);
       console.log(`🚀 Time 2 consultado: ${timeAway}`);

       // Buscar os jogos dos dois times (mandante e visitante)
       const jogosHome = await buscarJogos(timeHome);
       const jogosAway = await buscarJogos(timeAway);

       let jogos = [...jogosHome, ...jogosAway];
       console.log(`📊 Total de jogos encontrados: ${jogos.length}`);

       // Processar os jogos corretamente, garantindo que não haja erros com times sem registros
       const jogosFormatados = [
           ...(jogosHome.length ? processarJogos(jogosHome, timeHome) : []),
           ...(jogosAway.length ? processarJogos(jogosAway, timeAway) : [])
       ];

       // Ordenar os jogos pela data mais recente primeiro
       const jogosOrdenados = jogosFormatados.sort((a, b) => {
           return new Date(b.data_hora + " " + b.hora) - new Date(a.data_hora + " " + a.hora);
       });

       console.log("📢 Jogos processados finalizados:", jogosOrdenados);
       res.json(jogosOrdenados);
   } catch (error) {
       console.error("🔥 Erro ao processar os dados:", error);
       res.status(500).send("Erro no servidor");
   }
});

// Função para buscar os jogos do time no banco de dados
const buscarJogos1 = async (team) => {
   const table = team.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
   console.log(`🔍 Consultando a tabela: ${table}`); 

   const tablesResult = await pool.query(
       `SELECT table_name FROM information_schema.tables WHERE table_name = $1`,
       [table]
   );
console.log(`📂 Resultado da consulta de tabelas:`, tablesResult.rows);  // Verifica o resultado da consulta

   if (tablesResult.rows.length > 0) {
       const querySQL = `
           SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
           FROM ${table} 
           WHERE (unaccent(timehome) ILIKE unaccent($1) OR unaccent(timeaway) ILIKE unaccent($1))
           ORDER BY TO_TIMESTAMP(data_hora, 'DD.MM.YYYY HH24:MI') DESC
           LIMIT 10
       `;

       console.log(`📄 Executando query para ${table}: ${querySQL}`);
       const jogosResult = await pool.query(querySQL, [team]);
       console.log(`📊 Resultado da consulta de jogos:`, jogosResult.rows);
       return jogosResult.rows;
   }

   return [];
};
// Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .normalize("NFD") 
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o') // Substitui o 'ó' por 'o'
        .replace(/[\s\-\.]/g, '') // Remove espaços, hífens e pontos
        .trim()
        .toLowerCase(); // Deixa tudo minúsculo
}

// Função para processar os jogos e determinar os resultados
const processarJogos1 = (jogos, team) => {
    const teamNormalizado = normalizarNomeTime(team); // Normaliza o nome do time pesquisado

    return jogos.map(row => {
        const { timehome, timeaway, resultadohome, resultadoaway, data_hora } = row;

        console.log(`🔄 Processando jogo: ${timehome} vs ${timeaway}, Resultado: ${resultadohome} - ${resultadoaway}, Data: ${data_hora}`);

        // Normaliza os nomes dos times
        const timehomeNormalizado = normalizarNomeTime(timehome);
        const timeawayNormalizado = normalizarNomeTime(timeaway);

        console.log(`📌 Time da casa recebido: ${timehomeNormalizado}`);
        console.log(`📌 Time visitante recebido: ${timeawayNormalizado}`);
        console.log(`🔍 Team: ${teamNormalizado}`);

        // Definir o status do jogo para o time pesquisado
        let resultado = "🤝 Empate"; // Padrão é empate
        if (teamNormalizado === timehomeNormalizado) {
            // O time pesquisado jogou como mandante
            if (resultadohome > resultadoaway) resultado = `${team} ✅`; // Vitória do mandante
            else if (resultadohome < resultadoaway) resultado = `${team} ❌`; // Derrota do mandante
        } else if (teamNormalizado === timeawayNormalizado) {
            // O time pesquisado jogou como visitante
            if (resultadoaway > resultadohome) resultado = `${team} ✅`; // Vitória do visitante
            else if (resultadoaway < resultadohome) resultado = `${team} ❌`; // Derrota do visitante
        }

        // Processar data e hora corretamente
        const [data, hora] = data_hora.split(" ");
        const dataFormatada = data.replace(/\./g, "/");

        return {
            data_hora: dataFormatada,
            hora,
            timehome,
            resultadohome,
            timeaway,
            resultadoaway,
            resultado // Indica vitória, derrota ou empate do time pesquisado
        };
    });
};

app.get("/ultimos5jogos", async (req, res) => {
    try {
        const timeHome = req.query.timeHome;
        const timeAway = req.query.timeAway;

        if (!timeHome || !timeAway) {
            return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
        }

        console.log(`🏠 Timehome consultado: ${timeHome}`);
        console.log(`🚀 Timeaway consultado: ${timeAway}`);

        // Buscar apenas os jogos do timeHome em casa
        const jogosHome = await buscarJogosEmCasa(timeHome);
        // Buscar apenas os jogos do timeAway fora de casa
        const jogosAway = await buscarJogosFora(timeAway);

        console.log(`📊 Jogos do ${timeHome} em casa encontrados: ${jogosHome.length}`);
        console.log(`📊 Jogos do ${timeAway} fora de casa encontrados: ${jogosAway.length}`);

        // Processar os jogos
        const jogosHomeFormatados = processarJogos(jogosHome, timeHome);
        const jogosAwayFormatados = processarJogos(jogosAway, timeAway);

        // Pegar os últimos 5 jogos de cada
        const ultimos5Home = jogosHomeFormatados.slice(0, 5);
        const ultimos5Away = jogosAwayFormatados.slice(0, 5);

        // Formatar os resultados
        const { resultadosHome } = formatarResultados(ultimos5Home, timeHome);
        const { resultadosAway } = formatarResultados(ultimos5Away, timeAway);

        res.json({
            timeHome: {
                nome: timeHome,
                desempenho_casa: resultadosHome // Resultados dos últimos 5 jogos em casa
            },
            timeAway: {
                nome: timeAway,
                desempenho_fora: resultadosAway // Resultados dos últimos 5 jogos fora
            }
        });
    } catch (error) {
        console.error("🔥 Erro ao processar os dados:", error);
        res.status(500).send("Erro no servidor");
    }
});

// Função para buscar jogos do timeHome apenas em casa
const buscarJogosEmCasa = async (team) => {
    const table = team.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

    const querySQL = `
        SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
        FROM ${table} 
        WHERE unaccent(timehome) ILIKE unaccent($1)
        ORDER BY TO_TIMESTAMP(data_hora, 'DD.MM.YYYY HH24:MI') DESC
        LIMIT 5
    `;

    const jogosResult = await pool.query(querySQL, [team]);
    return jogosResult.rows;
};

// Função para buscar jogos do timeAway apenas fora de casa
const buscarJogosFora = async (team) => {
    const table = team.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";

    const querySQL = `
        SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
        FROM ${table} 
        WHERE unaccent(timeaway) ILIKE unaccent($1)
        ORDER BY TO_TIMESTAMP(data_hora, 'DD.MM.YYYY HH24:MI') DESC
        LIMIT 5
    `;

    const jogosResult = await pool.query(querySQL, [team]);
    return jogosResult.rows;
};
// Função para buscar os jogos do time no banco de dados
const buscarJogos = async (team, isHome) => {
   const table = team.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
   console.log(`🔍 Consultando a tabela: ${table}`);

   const tablesResult = await pool.query(
       `SELECT table_name FROM information_schema.tables WHERE table_name = $1`,
       [table]
   );

   if (tablesResult.rows.length > 0) {
       const querySQL = `
           SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
           FROM ${table} 
           WHERE ${isHome ? "unaccent(timehome) ILIKE unaccent($1)" : "unaccent(timeaway) ILIKE unaccent($1)"}
           ORDER BY TO_TIMESTAMP(data_hora, 'DD.MM.YYYY HH24:MI') DESC
           LIMIT 5
       `;

       console.log(`📄 Executando query para ${table}: ${querySQL}`);
       const jogosResult = await pool.query(querySQL, [team]);
       return jogosResult.rows;
   }

   return [];
};

// Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim()
        .toLowerCase(); // Deixa tudo minúsculo
}

// Função para processar os jogos e determinar os resultados
const processarJogos = (jogos, team) => {
    const teamNormalizado = normalizarNomeTime(team);

       console.log(`🏠 Team NormalizadoII 1 : ${teamNormalizado}`);
    return jogos.map(row => {
        const { timehome, timeaway, resultadohome, resultadoaway, data_hora } = row;

        // Normaliza os nomes dos times
        const timehomeNormalizado = normalizarNomeTime(timehome);
        const timeawayNormalizado = normalizarNomeTime(timeaway);

       console.log(`🏠 Jogos NormalizadoII 1 : ${timehomeNormalizado}`);
       console.log(`🚀 Jogos NormalizadoII 2 : ${timeawayNormalizado}`);

        // Definir o status do jogo para o time pesquisado
        let resultado = "🤝"; // Padrão é empate
        if (teamNormalizado === timehomeNormalizado) {
            if (resultadohome > resultadoaway) resultado = "✅"; // Vitória do mandante
            else if (resultadohome < resultadoaway) resultado = "❌"; // Derrota do mandante
        } else if (teamNormalizado === timeawayNormalizado) {
            if (resultadoaway > resultadohome) resultado = "✅"; // Vitória do visitante
            else if (resultadoaway < resultadohome) resultado = "❌"; // Derrota do visitante
        }

        // Processar data corretamente
        const [data, hora] = data_hora.split(" ");
        const dataFormatada = data.replace(/\./g, "/");

        return {
            data_hora: dataFormatada,
            hora,
            timehome,
            resultadohome,
            timeaway,
            resultadoaway,
            resultado
        };
    });
};

// Função para formatar os resultados como 'VVDED' para timeHome e 'VDDVE' para timeAway
const formatarResultados = (jogos, team) => {
    let resultadosHome = "";
    let resultadosAway = "";

    jogos.forEach(jogo => {
        const timePesquisado = normalizarNomeTime(team);
        const timehomeNormalizado = normalizarNomeTime(jogo.timehome);
        const timeawayNormalizado = normalizarNomeTime(jogo.timeaway);

        if (timehomeNormalizado === timePesquisado) {
            resultadosHome += jogo.resultado;
        } else if (timeawayNormalizado === timePesquisado) {
            resultadosAway += jogo.resultado;
        }
    });

    return { resultadosHome, resultadosAway };
};



app.get("/ultimos10jogostop10", async (req, res) => {
   try {
       const timeHome = req.query.timeHome;
       const timeAway = req.query.timeAway;

       if (!timeHome || !timeAway) {
           return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
       }

       // 🔄 Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o')
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '') // Remove pontos
        .trim(); 
}


       // 🔄 Normaliza os nomes dos times da requisição
       const timeHomeNormalizado = normalizarNomeTime(timeHome);
       const timeAwayNormalizado = normalizarNomeTime(timeAway);

       console.log(`🏠 Time 1 consultado: ${timeHome}`);
       console.log(`🚀 Time 2 consultado: ${timeAway}`);

       // Buscar os jogos dos dois times (mandante e visitante)
       const jogosHome = await buscarJogos(timeHome);
       const jogosAway = await buscarJogos(timeAway);

       let jogos = [...jogosHome, ...jogosAway];
       console.log(`📊 Total de jogos encontrados: ${jogos.length}`);

       // Processar os jogos corretamente, garantindo que não haja erros com times sem registros
       const jogosFormatados = [
           ...(jogosHome.length ? processarJogos(jogosHome, timeHome) : []),
           ...(jogosAway.length ? processarJogos(jogosAway, timeAway) : [])
       ];

       // Ordenar os jogos pela data mais recente primeiro
       const jogosOrdenados = jogosFormatados.sort((a, b) => {
           return new Date(b.data_hora + " " + b.hora) - new Date(a.data_hora + " " + a.hora);
       });

       console.log("📢 Jogos processados finalizados:", jogosOrdenados);
       res.json(jogosOrdenados);
   } catch (error) {
       console.error("🔥 Erro ao processar os dados:", error);
       res.status(500).send("Erro no servidor");
   }
});

// Função para buscar os jogos do time no banco de dados
const buscarJogos2 = async (team) => {
   const table = team.toLowerCase().replace(/\s/g, '_').replace(/\./g, '').replace(/[\u0300-\u036f]/g, '').replace('ã', 'a').replace('ó', 'o').replace(/[\s\-]/g, '').replace(/\./g, '') + "_futebol";
   console.log(`🔍 Consultando a tabela: ${table}`); 

   const tablesResult = await pool.query(
       `SELECT table_name FROM information_schema.tables WHERE table_name = $1`,
       [table]
   );
console.log(`📂 Resultado da consulta de tabelas:`, tablesResult.rows);  // Verifica o resultado da consulta

   if (tablesResult.rows.length > 0) {
       const querySQL = `
           SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
           FROM ${table} 
           WHERE (unaccent(timehome) ILIKE unaccent($1) OR unaccent(timeaway) ILIKE unaccent($1))
           ORDER BY TO_TIMESTAMP(data_hora, 'DD.MM.YYYY HH24:MI') DESC
           LIMIT 10
       `;

       console.log(`📄 Executando query para ${table}: ${querySQL}`);
       const jogosResult = await pool.query(querySQL, [team]);
       console.log(`📊 Resultado da consulta de jogos:`, jogosResult.rows);
       return jogosResult.rows;
   }

   return [];
};
// Função para normalizar os nomes dos times
function normalizarNomeTime(nome) {
    return nome
        .normalize("NFD") 
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace('ã', 'a') // Substitui o 'ã' por 'a'
        .replace('ó', 'o') // Substitui o 'ó' por 'o'
        .replace(/[\s\-\.]/g, '') // Remove espaços, hífens e pontos
        .trim()
        .toLowerCase(); // Deixa tudo minúsculo
}

// Função para processar os jogos e determinar os resultados
const processarJogos2 = (jogos, team) => {
    const teamNormalizado = normalizarNomeTime(team); // Normaliza o nome do time pesquisado

    return jogos.map(row => {
        const { timehome, timeaway, resultadohome, resultadoaway, data_hora } = row;

        console.log(`🔄 Processando jogo: ${timehome} vs ${timeaway}, Resultado: ${resultadohome} - ${resultadoaway}, Data: ${data_hora}`);

        // Normaliza os nomes dos times
        const timehomeNormalizado = normalizarNomeTime(timehome);
        const timeawayNormalizado = normalizarNomeTime(timeaway);

        console.log(`📌 Time da casa recebido: ${timehomeNormalizado}`);
        console.log(`📌 Time visitante recebido: ${timeawayNormalizado}`);
        console.log(`🔍 Team: ${teamNormalizado}`);

        // Definir o status do jogo para o time pesquisado
        let resultado = "🤝"; // Padrão é empate
        if (teamNormalizado === timehomeNormalizado) {
            // O time pesquisado jogou como mandante
            if (resultadohome > resultadoaway) resultado = "✅"; // Vitória do mandante
            else if (resultadohome < resultadoaway) resultado = "❌"; // Derrota do mandante
        } else if (teamNormalizado === timeawayNormalizado) {
            // O time pesquisado jogou como visitante
            if (resultadoaway > resultadohome) resultado = "✅"; // Vitória do visitante
            else if (resultadoaway < resultadohome) resultado = "❌"; // Derrota do visitante
        }

        // Processar data e hora corretamente
        const [data, hora] = data_hora.split(" ");
        const dataFormatada = data.replace(/\./g, "/");

        return {
            data_hora: dataFormatada,
            hora,
            timehome,
            resultadohome,
            timeaway,
            resultadoaway,
            resultado // Indica vitória, derrota ou empate do time pesquisado
        };
    });
};
// Função para formatar os resultados como 'VVDED' para timeHome e 'VDDVE' para timeAway
const formatarResultados2 = (jogos, team) => {
    let resultadosHome = "";
    let resultadosAway = "";

    jogos.forEach(jogo => {
        const timePesquisado = normalizarNomeTime(team);
        const timehomeNormalizado = normalizarNomeTime(jogo.timehome);
        const timeawayNormalizado = normalizarNomeTime(jogo.timeaway);

        if (timehomeNormalizado === timePesquisado) {
            resultadosHome += jogo.resultado; // Jogos em casa
        } else if (timeawayNormalizado === timePesquisado) {
            resultadosAway += jogo.resultado; // Jogos fora de casa
        }
    });

    return { resultadosHome, resultadosAway };
};





//Futebol------------------Futebol------------futebol------------------------//Futebol------------------Futebol------------futebol------------------------//Futebol------------------Futebol------------futebol------------------------
//NBA

// Rota para exibir links únicos
app.get('/links', async (req, res) => {
    const client = await pool.connect();
    try {
        const result = await client.query(`
            SELECT DISTINCT ON (link) team_name, link, event_time
            FROM links
            ORDER BY link, event_time DESC
        `);
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao buscar dados dos links.');
    } finally {
        client.release();
    }
});

// Rota para exibir links únicos
app.get('/linksfut', async (req, res) => {
    const client = await pool.connect();
    try {
        // Consulta para pegar todas as tabelas com o sufixo "_links"
        const tablesResult = await client.query(`
            SELECT table_name
            FROM information_schema.tables
            WHERE table_name LIKE '%_links'
        `);

        const tableNames = tablesResult.rows.map(row => row.table_name);
        if (tableNames.length === 0) {
            return res.status(404).send('Nenhuma tabela encontrada com sufixo "_links".');
        }

        // Construção da consulta para pegar os dados das tabelas
        const queries = tableNames.map(table => `
            SELECT team_name, link, event_time
            FROM ${table}
        `);

        // Junta todas as consultas com UNION ALL
        const finalQuery = queries.join(' UNION ALL ');

        // Adiciona o ORDER BY na consulta final
        const orderedQuery = `
            ${finalQuery}
            ORDER BY link, event_time DESC
        `;

        console.log('Consulta gerada:', orderedQuery); // Log para verificar a consulta gerada

        // Executa a consulta final
        const result = await client.query(orderedQuery);
        res.json(result.rows);
    } catch (err) {
        console.error('Erro na consulta SQL:', err);
        res.status(500).send('Erro ao buscar dados das tabelas.');
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
        const excludedTables = ['odds', 'links', 'users', 'nba_classificacao'];

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
app.post('/execute-odds', (req, res) => {
    const oddsPath = path.join(__dirname, 'odds.js');
    console.log('Executando script odds.js...');
    exec(`node ${oddsPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erro ao executar o script: ${error.message}`);
            return res.status(500).send(`Erro ao executar o script: ${error.message}`);
        }
        if (stderr) {
            console.error(`Erro no script: ${stderr}`);
            return res.status(500).send(`Erro no script: ${stderr}`);
        }
        console.log(`Resultado do script: ${stdout}`);
        res.send('Script Odds executado com sucesso.');
    });
});


// Rota para executar o script saveLinks.js
app.post('/execute-script', (req, res) => {
    const saveLinksPath = path.join(__dirname, 'public', 'saveLinks.js');
    console.log('Executando script links NBA.js...');
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
        res.send('Links NBA executado com sucesso.');
    });
});


// Função para executar um script Node.js de forma segura

function runScript(scriptPath, res, scriptName, tableName) {
    console.log(`🚀 Executando script: ${scriptPath} com tableName: ${tableName}`);

    exec(`node ${scriptPath} ${tableName}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`❌ Erro ao executar ${scriptName}: ${error.message}`);

            // Verificando se o erro é um timeout e, se for, chamando o segundo script
            if (error.message.includes('TimeoutError')) {
                console.log("🔄 Timeout detectado! Chamando o segundo script...");
                // Caminho do segundo script
                const secondScriptPath = '/opt/render/project/src/public/second_script.js';
                
                // Executando o segundo script
                exec(`node ${secondScriptPath} ${tableName}`, (secondError, secondStdout, secondStderr) => {
                    if (secondError) {
                        console.error(`❌ Erro ao executar o segundo script: ${secondError.message}`);
                        return res.status(500).json({ success: false, message: `Erro ao executar o segundo script.` });
                    }
                    if (secondStderr) {
                        console.warn(`⚠️ Saída com alerta (Segundo script): ${secondStderr}`);
                    }
                    console.log(`✅ Segundo script executado com sucesso: ${secondStdout}`);
                    res.json({ success: true, message: `Segundo script executado com sucesso.` });
                });
                return;  // Não continue com o processo de erro do primeiro script
            }
            
            return res.status(500).json({ success: false, message: `Erro ao executar ${scriptName}.` });
        }

        if (stderr) {
            console.warn(`⚠️ Saída com alerta (${scriptName}): ${stderr}`);
        }

        console.log(`✅ ${scriptName} executado com sucesso: ${stdout}`);
        res.json({ success: true, message: `${scriptName} executado com sucesso.` });
    });
}

// Rota para executar a atualização de jogadores
app.post('/execute-Jogadores', async (req, res) => {
    const { links } = req.body; // Links das equipes selecionadas

    if (!Array.isArray(links) || links.length === 0) {
        return res.status(400).send('Nenhum link selecionado para Jogadores.');
    }

    try {
        console.log('Links selecionados para Jogadores:', links);

        for (const link of links) {
            await scrapeResults1(link); // Certifique-se de que a função foi importada
        }

        res.status(200).send('Jogadores atualizados com sucesso!');
    } catch (error) {
        console.error('Erro ao atualizar Jogadores:', error);
        res.status(500).send('Erro ao atualizar Jogadores.');
    }
});
// Rota para executar a atualização de jogadores
app.post('/execute-futebol', async (req, res) => {
    console.log('Recebendo requisição:', req.body);
    const { laliga_links } = req.body;

    if (!Array.isArray(laliga_links) || laliga_links.length === 0) {
        return res.status(400).send('Nenhum link selecionado para Futebol.');
    }

    try {
        console.log('Dados recebidos:', laliga_links);

        for (const item of laliga_links) {
            const { link, team_name } = item;
            console.log(`Processando: team_name = ${team_name}, link = ${link}`);
            await scrapeResults10(link, team_name);
        }

        res.status(200).send('Time atualizado com sucesso!');
    } catch (error) {
        console.error('Erro ao atualizar Jogadores:', error);
        res.status(500).send('Erro ao atualizar Jogadores.');
    }
});



// Rota para executar a atualização de jogadores
app.post('/execute-lesoes', async (req, res) => {
    const { links } = req.body; // Links das equipes selecionadas

    if (!Array.isArray(links) || links.length === 0) {
        return res.status(400).send('Nenhum link selecionado para Jogadores Lesionados.');
    }

    try {
        console.log('Links selecionados para Jogadores Lesionados:', links);

        for (const link of links) {
            await scrapeResults3(link); // Certifique-se de que a função foi importada
        }

        res.status(200).send('Jogadores Lesionados atualizados com sucesso!');
    } catch (error) {
        console.error('Erro ao atualizar Jogadores Lesionados:', error);
        res.status(500).send('Erro ao atualizar Jogadores Lesionadoss.');
    }
});

// Rota para executar a atualização de jogos
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

// Rota para executar ambas as atualizações (Jogadores e Jogos)
app.post('/execute-both', async (req, res) => {
    const { links } = req.body; // Links das equipes selecionadas

    // Verificação de entrada
    if (!Array.isArray(links) || links.length === 0) {
        return res.status(400).send('Nenhum link selecionado.');
    }

    try {
        console.log('Links selecionados para Jogadores e Jogos:', links);

        // Atualizar jogadores
        console.log('Iniciando atualização dos jogadores...');
        for (const link of links) {
            await scrapeResults(link); // Certifique-se de que a função foi importada
        }
        console.log('Atualização dos jogadores concluída.');

        // Atualizar jogos
        console.log('Iniciando atualização dos jogos...');
        for (const link of links) {
            await scrapeResults1(link); // Certifique-se de que a função foi importada
        }
        console.log('Atualização dos jogos concluída.');

        // Enviar resposta de sucesso
        res.status(200).send('Jogadores e Jogos atualizados com sucesso!');
    } catch (error) {
        console.error('Erro ao atualizar Jogadores e Jogos:', error);
        res.status(500).send('Erro ao atualizar Jogadores e Jogos.');
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

// Rota para buscar apenas os valores da coluna 'handicap' da tabela 'odds'
app.get('/handicap', async (req, res) => {
    try {
        // Seleciona os dados que você precisa para o novo handicap
        // Por exemplo, time_home, time_away e handicap.
        const result = await pool.query(`
            SELECT time_home, time_away, handicap
            FROM odds
        `);
        res.json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar dados do novo handicap:', error);
        res.status(500).json({ error: 'Erro ao buscar dados do novo handicap' });
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
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
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
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
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

app.get('/mediapontosgeral', async (req, res) => {
    try {
        // Consultar times na tabela "odds"
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
                    SELECT home_score 
                    FROM ${homeTable} 
                    WHERE home_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 12
                `, [time_home]);

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
                    SELECT away_score 
                    FROM ${awayTable} 
                    WHERE away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 12
                `, [time_away]);

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
                total_pontos: homeAvg + awayAvg,
            });
        }

        // Enviar resultados em JSON
        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});

app.get('/ultimosjogos1', async (req, res) => {
    try {
        // Consultar times na tabela "odds"
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

            const homeGames = [];
            const awayGames = [];

            // Buscar os últimos 3 jogos do time da casa
            if (tableNames.includes(homeTable)) {
                const homeGamesResult = await pool.query(`
                    SELECT 
                        home_team, away_team, home_score, away_score 
                    FROM ${homeTable} 
                    WHERE home_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 5
                `, [time_home]);

                homeGamesResult.rows.forEach(game => {
                    const homeScore = parseInt(game.home_score, 10);  // Converter para número
                    const awayScore = parseInt(game.away_score, 10);  // Converter para número
                    const totalPoints = homeScore + awayScore;  // Sumar os pontos corretamente
                    const result = homeScore > awayScore ? 'Venceu' : 'Perdeu';
                    homeGames.push({
                        adversario: game.away_team,
                        resultado: `${game.home_team} X ${game.away_team} Total Pontos = ${homeScore} x ${awayScore}`,
                        status: `${game.home_team} ${result}`
                    });
                });
            }

            // Buscar os últimos 3 jogos do time visitante
            if (tableNames.includes(awayTable)) {
                const awayGamesResult = await pool.query(`
                    SELECT 
                        home_team, away_team, home_score, away_score 
                    FROM ${awayTable} 
                    WHERE away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 5
                `, [time_away]);

                awayGamesResult.rows.forEach(game => {
                    const homeScore = parseInt(game.home_score, 10);  // Converter para número
                    const awayScore = parseInt(game.away_score, 10);  // Converter para número
                    const totalPoints = homeScore + awayScore;  // Sumar os pontos corretamente
                    const result = awayScore > homeScore ? 'Venceu' : 'Perdeu';
                    awayGames.push({
                        adversario: game.home_team,
                        resultado: `${game.home_team} X ${game.away_team} Total Pontos = ${homeScore} x ${awayScore}`,
                        status: `${game.away_team} ${result}`
                    });
                });
            }

            results.push({
                time_home,
                home_last_games: homeGames,
                time_away,
                away_last_games: awayGames,
            });
        }

        // Enviar resultados em JSON
        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/ultimosjogos', async (req, res) => {
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            const tablesResult = await pool.query(
                `SELECT table_name FROM information_schema.tables WHERE table_name = $1 OR table_name = $2`, 
                [homeTable, awayTable]
            );
            const tableNames = tablesResult.rows.map(row => row.table_name);

            let homeGames = [];
            let awayGames = [];
            let homeWins = 0;
            let awayWins = 0;

            if (tableNames.includes(homeTable)) {
                const homeGamesResult = await pool.query(
                    `SELECT home_team, away_team, home_score, away_score FROM ${homeTable} WHERE home_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 10
                `, 
                    [time_home]
                );

                homeGamesResult.rows.forEach(game => {
                    const homeScore = parseInt(game.home_score, 10);
                    const awayScore = parseInt(game.away_score, 10);
                    const result = homeScore > awayScore ? 'Venceu' : 'Perdeu';
                    if (homeScore > awayScore) homeWins++;
                    
                    homeGames.push({
                        adversario: game.away_team,
                        resultado: `${game.home_team} X ${game.away_team} Total Pontos = ${homeScore} x ${awayScore}`,
                        status: `${game.home_team} ${result}`
                    });
                });
            }

            if (tableNames.includes(awayTable)) {
                const awayGamesResult = await pool.query(
                    `SELECT home_team, away_team, home_score, away_score FROM ${awayTable} WHERE away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 10
                `, 
                    [time_away]
                );

                awayGamesResult.rows.forEach(game => {
                    const homeScore = parseInt(game.home_score, 10);
                    const awayScore = parseInt(game.away_score, 10);
                    const result = awayScore > homeScore ? 'Venceu' : 'Perdeu';
                    if (awayScore > homeScore) awayWins++;
                    
                    awayGames.push({
                        adversario: game.home_team,
                        resultado: `${game.home_team} X ${game.away_team} Total Pontos = ${homeScore} x ${awayScore}`,
                        status: `${game.away_team} ${result}`
                    });
                });
            }

            results.push({
                time_home,
                home_last_games: homeGames,
                home_wins_last_10: homeWins,
                time_away,
                away_last_games: awayGames,
                away_wins_last_10: awayWins
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});



app.get('/ultimosjogos2', async (req, res) => {
    try {
        const { time } = req.query; // O time vem pela query params, por exemplo: /ultimosjogos?time=Oklahoma City Thunder
        if (!time) {
            return res.status(400).send('Time não informado');
        }

        const timeFormatado = time.toLowerCase().replace(/\s/g, '_');
        console.log(`Time recebido: ${time}`);
        console.log(`Nome da tabela formatada: ${timeFormatado}`);
        
        // Verificar se a tabela do time existe
        const tablesResult = await pool.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name = $1
        `, [timeFormatado]);

        console.log(`Resultado da verificação da tabela:`, tablesResult.rows);

        if (!tablesResult.rows.length) {
            console.log('Tabela não encontrada para o time informado.');
            return res.status(404).send('Tabela do time não encontrada');
        }

        // Buscar os 3 últimos jogos do time, seja como time da casa ou visitante
        const querySQL = `
            SELECT home_team, away_team, home_score, away_score, datahora, id 
            FROM ${timeFormatado} 
            WHERE home_team = $1 OR away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        WHEN datahora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 5
        `;
        console.log(`Query SQL que será executada: ${querySQL}`);

        const jogosResult = await pool.query(querySQL, [time]);
        console.log(`Jogos retornados pela query:`, jogosResult.rows);

        const jogos = jogosResult.rows.map(row => {
            const { home_team, away_team, home_score, away_score, datahora } = row;
        
            let timeA, timeB, pontosA, pontosB;
        
            if (home_team.toLowerCase() === time.toLowerCase()) {
                // Time é mandante
                timeA = home_team; // Time do lado esquerdo
                timeB = away_team; // Adversário
                pontosA = home_score; // Pontos do time mandante
                pontosB = away_score; // Pontos do adversário
            } else if (away_team.toLowerCase() === time.toLowerCase()) {
                // Time é visitante
                timeB = away_team; // Time consultado no lado direito
                timeA = home_team; // Adversário
                pontosB = away_score; // Pontos do time visitante
                pontosA = home_score; // Pontos do adversário
            } else {
                throw new Error('O time escolhido não participou deste jogo.');
            }
        
            // Calculando o resultado baseado no time consultado
            let statusResultado;
            if (time.toLowerCase() === timeA.toLowerCase()) {
                // Time consultado é o mandante
                if (parseInt(pontosA, 10) > parseInt(pontosB, 10)) {
                    statusResultado = `${timeA} ✅`; // Venceu
                } else if (parseInt(pontosA, 10) < parseInt(pontosB, 10)) {
                    statusResultado = `${timeA} ❌`; // Perdeu
                } else {
                    statusResultado = 'Empate';
                }
            } else if (time.toLowerCase() === timeB.toLowerCase()) {
                // Time consultado é o visitante
                if (parseInt(pontosB, 10) > parseInt(pontosA, 10)) {
                    statusResultado = `${timeB} ✅`; // Venceu
                } else if (parseInt(pontosB, 10) < parseInt(pontosA, 10)) {
                    statusResultado = `${timeB} ❌`; // Perdeu
                } else {
                    statusResultado = 'Empate';
                }
            }
        
            // Processar data e hora
            const [data, hora] = datahora.split(' '); // Divide o formato "16.01. 01:00"
            const dataFormatada = data.replace('.', '/').slice(0, -1); // Formatar "16.01." para "16/01"
        
            return {
                timeA,
                timeB,
                pontosA,
                pontosB,
                resultado: statusResultado,
                data: dataFormatada,
                hora,
            };
        });
        
        
        

        console.log('Jogos processados finalizados:', jogos);

        // Retornar os jogos com data e hora no formato JSON
        res.json(jogos);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/ultimosjogos4', async (req, res) => {
    try {
        // Consultar times na tabela "odds"
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

            // Verificar tabelas existentes
            const tablesResult = await pool.query(
                `SELECT table_name 
                 FROM information_schema.tables 
                 WHERE table_name = $1 OR table_name = $2`,
                [homeTable, awayTable]
            );

            const tableNames = tablesResult.rows.map(row => row.table_name);

            // Arrays para armazenar vitórias e derrotas
            const homeWins = []; // Vitórias do time_home em casa
            const homeLosses = []; // Derrotas do time_home em casa
            const awayWins = []; // Vitórias do time_away fora de casa
            const awayLosses = []; // Derrotas do time_away fora de casa

            // Buscar jogos do time_home em casa
            if (tableNames.includes(homeTable)) {
                const homeGamesResult = await pool.query(
                    `SELECT 
                        home_team, away_team, home_score, away_score, datahora 
                     FROM ${homeTable} 
                     WHERE home_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC NULLS LAST`,
    [time_home]);

                // Filtrar vitórias e derrotas do time_home em casa
                for (const game of homeGamesResult.rows) {
                    const homeScore = parseInt(game.home_score, 10);
                    const awayScore = parseInt(game.away_score, 10);

                    if (homeScore > awayScore && homeWins.length < 5) {
                        homeWins.push({
                            adversario: game.away_team,
                            diferenca: homeScore - awayScore,
                            datahora: game.datahora
                        });
                    } else if (homeScore < awayScore && homeLosses.length < 5) {
                        homeLosses.push({
                            adversario: game.away_team,
                            diferenca: awayScore - homeScore,
                            datahora: game.datahora
                        });
                    }

                    // Parar se já encontrou 5 vitórias e 5 derrotas
                    if (homeWins.length === 5 && homeLosses.length === 5) break;
                }
            }

            // Buscar jogos do time_away fora de casa
            if (tableNames.includes(awayTable)) {
                const awayGamesResult = await pool.query(
                    `SELECT 
                        home_team, away_team, home_score, away_score, datahora 
                     FROM ${awayTable} 
                     WHERE away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC NULLS LAST`, [time_away]);

                // Filtrar vitórias e derrotas do time_away fora de casa
                for (const game of awayGamesResult.rows) {
                    const homeScore = parseInt(game.home_score, 10);
                    const awayScore = parseInt(game.away_score, 10);

                    if (awayScore > homeScore && awayWins.length < 5) {
                        awayWins.push({
                            adversario: game.home_team,
                            diferenca: awayScore - homeScore,
                            datahora: game.datahora
                        });
                    } else if (awayScore < homeScore && awayLosses.length < 5) {
                        awayLosses.push({
                            adversario: game.home_team,
                            diferenca: homeScore - awayScore,
                            datahora: game.datahora
                        });
                    }

                    // Parar se já encontrou 5 vitórias e 5 derrotas
                    if (awayWins.length === 5 && awayLosses.length === 5) break;
                }
            }

            // Calcular médias
            const homeWinAvg = homeWins.length > 0 ? (homeWins.reduce((sum, win) => sum + win.diferenca, 0) / homeWins.length).toFixed(2) : 0;
            const homeLossAvg = homeLosses.length > 0 ? (homeLosses.reduce((sum, loss) => sum + loss.diferenca, 0) / homeLosses.length).toFixed(2) : 0;
            const awayWinAvg = awayWins.length > 0 ? (awayWins.reduce((sum, win) => sum + win.diferenca, 0) / awayWins.length).toFixed(2) : 0;
            const awayLossAvg = awayLosses.length > 0 ? (awayLosses.reduce((sum, loss) => sum + loss.diferenca, 0) / awayLosses.length).toFixed(2) : 0;

            results.push({
                time_home,
                home_last_games: {
                    wins: homeWins,
                    losses: homeLosses,
                    win_avg: homeWinAvg,
                    loss_avg: homeLossAvg
                },
                time_away,
                away_last_games: {
                    wins: awayWins,
                    losses: awayLosses,
                    win_avg: awayWinAvg,
                    loss_avg: awayLossAvg
                },
            });
        }

        // Enviar resultados em JSON
        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});

app.get('/ultimos-10-jogos', async (req, res) => {
    try {
        const { time, location } = req.query; // Recebe o nome do time e a localização (home/away)

        if (!time || !location) {
            return res.status(400).send('Time e localização (home/away) são obrigatórios.');
        }

        // Formatar o nome do time para o padrão do banco de dados
        const timeFormatado = decodeURIComponent(time).toLowerCase().replace(/\s/g, '_');
        console.log(`Time recebido: ${time}`);
        console.log(`Nome da tabela formatada: ${timeFormatado}`);

        // Verificar se a tabela do time existe no banco de dados
        const tablesResult = await pool.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name = $1
        `, [timeFormatado]);

        if (!tablesResult.rows.length) {
            console.log('Tabela não encontrada para o time informado.');
            return res.status(404).send('Tabela do time não encontrada');
        }

        // Definir a coluna correta com base na localização (home/away)
        let colunaFiltro;
        if (location === 'home') {
            colunaFiltro = 'home_team';
        } else if (location === 'away') {
            colunaFiltro = 'away_team';
        } else {
            return res.status(400).send('Parâmetro location deve ser "home" ou "away".');
        }

        // Buscar os últimos 10 jogos do time na posição correta (casa ou fora)
        const querySQL = `
            SELECT home_team, away_team, home_score, away_score, datahora, id 
            FROM ${timeFormatado} 
            WHERE ${colunaFiltro} = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 1  -- Considera casos com "Após Prol." ou sem
        ELSE 2  
    END,
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 
            TO_TIMESTAMP(CONCAT('2025.', REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g')), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g'), 'DD.MM.YYYY')
    END DESC
            LIMIT 10
        `;

        console.log(`Query SQL que será executada: ${querySQL}`);

        const { rows } = await pool.query(querySQL, [time]);

        res.json(rows); // Retorna os jogos encontrados

    } catch (error) {
        console.error("Erro ao buscar os últimos 10 jogos:", error);
        res.status(500).json({ error: "Erro ao buscar os últimos 10 jogos." });
    }
});


app.get('/gamestats', async (req, res) => {
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');

            const confrontationResult = await pool.query(
                `SELECT home_team, away_team, home_score, away_score
                 FROM ${homeTable}
                 WHERE (home_team = $1 AND away_team = $2)
                    OR (home_team = $2 AND away_team = $1)`,
                [time_home, time_away]
            );

            const confrontations = confrontationResult.rows;

            let totalDifferenceHome = 0;
            let totalDifferenceAway = 0;
            let totalGames = confrontations.length;
            let homeWins = 0;
            let awayWins = 0;

            const games = [];

            confrontations.forEach(row => {
                const homeScore = parseInt(row.home_score, 10) || 0;
                const awayScore = parseInt(row.away_score, 10) || 0;
                const difference = Math.abs(homeScore - awayScore);

                // Identificar quem venceu e acumular diferenças para cada time
                if (homeScore > awayScore) {
                    if (row.home_team === time_home) {
                        homeWins++;
                        totalDifferenceHome += difference; // Vitória do time_home
                    } else {
                        awayWins++;
                        totalDifferenceAway += difference; // Vitória do time_away
                    }
                } else if (awayScore > homeScore) {
                    if (row.away_team === time_home) {
                        homeWins++;
                        totalDifferenceHome += difference; // Vitória do time_home
                    } else {
                        awayWins++;
                        totalDifferenceAway += difference; // Vitória do time_away
                    }
                }

                games.push({
                    home_team: row.home_team,
                    away_team: row.away_team,
                    home_score: homeScore,
                    away_score: awayScore,
                    difference: homeScore - awayScore
                });
            });

            // Calcular a média da diferença de pontos para cada time
            const avgDifferenceHome = totalGames > 0 ? (totalDifferenceHome / totalGames).toFixed(2) : "0.00";
            const avgDifferenceAway = totalGames > 0 ? (totalDifferenceAway / totalGames).toFixed(2) : "0.00";

            results.push({
                time_home,
                time_away,
                avg_difference_home: avgDifferenceHome, // Média do time_home
                avg_difference_away: avgDifferenceAway, // Média do time_away
                home_wins: homeWins,
                away_wins: awayWins,
                games
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/handpontos', async (req, res) => {
    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');

            const confrontationResult = await pool.query(
                `SELECT home_team, away_team, home_score, away_score, id
                 FROM ${homeTable}
                 WHERE (home_team = $1 AND away_team = $2)
                    OR (home_team = $2 AND away_team = $1)
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC NULLS LAST LIMIT 10`,
                [time_home, time_away]
            );

            const confrontations = confrontationResult.rows;

            let totalDifferenceHome = 0;
            let totalDifferenceAway = 0;
            let totalGames = confrontations.length;
            let homeWins = 0;
            let awayWins = 0;

            const games = [];

            confrontations.forEach(row => {
                const homeScore = parseInt(row.home_score, 10) || 0;
                const awayScore = parseInt(row.away_score, 10) || 0;
                const difference = Math.abs(homeScore - awayScore);

                // Identificar quem venceu e acumular diferenças para cada time
                if (homeScore > awayScore) {
                    if (row.home_team === time_home) {
                        homeWins++;
                        totalDifferenceHome += difference; // Vitória do time_home
                    } else {
                        awayWins++;
                        totalDifferenceAway += difference; // Vitória do time_away
                    }
                } else if (awayScore > homeScore) {
                    if (row.away_team === time_home) {
                        homeWins++;
                        totalDifferenceHome += difference; // Vitória do time_home
                    } else {
                        awayWins++;
                        totalDifferenceAway += difference; // Vitória do time_away
                    }
                }

                games.push({
                    home_team: row.home_team,
                    away_team: row.away_team,
                    home_score: homeScore,
                    away_score: awayScore,
                    difference: homeScore - awayScore
                });
            });

            // Calcular a média da diferença de pontos para cada time
            const avgDifferenceHome = totalGames > 0 ? (totalDifferenceHome / totalGames).toFixed(2) : "0.00";
            const avgDifferenceAway = totalGames > 0 ? (totalDifferenceAway / totalGames).toFixed(2) : "0.00";

            // Contar os jogos com diferença maior ou igual à média nos últimos 10 jogos
            const last10Games = confrontations.slice(0, 10);  // Pega os últimos 10 jogos
            let homeLossesAboveAvg = 0;
            let awayLossesAboveAvg = 0;

            last10Games.forEach(row => {
                const homeScore = parseInt(row.home_score, 10) || 0;
                const awayScore = parseInt(row.away_score, 10) || 0;
                const difference = Math.abs(homeScore - awayScore);

                // Verificar se o jogo tem diferença maior ou igual à média
                if (difference >= avgDifferenceHome) {
                    if (homeScore < awayScore && row.home_team === time_home) {
                        homeLossesAboveAvg++;
                    }
                }

                if (difference >= avgDifferenceAway) {
                    if (awayScore < homeScore && row.away_team === time_home) {
                        awayLossesAboveAvg++;
                    }
                }
            });

            results.push({
                time_home,
                time_away,
                avg_difference_home: avgDifferenceHome, // Média do time_home
                avg_difference_away: avgDifferenceAway, // Média do time_away
                home_wins: homeWins,
                away_wins: awayWins,
                home_losses_above_avg: homeLossesAboveAvg, // Perdas do time_home com diferença maior ou igual à média
                away_losses_above_avg: awayLossesAboveAvg, // Perdas do time_away com diferença maior ou igual à média
                games
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});


app.get('/totalvitorias', async (req, res) => {
    try {
        const { time } = req.query; // O time vem pela query params, por exemplo: /totalvitorias?time=Oklahoma City Thunder
        if (!time) {
            return res.status(400).send('Time não informado');
        }

        const timeFormatado = time.toLowerCase().replace(/\s/g, '_');
        console.log(`Time recebido: ${time}`);
        console.log(`Nome da tabela formatada: ${timeFormatado}`);

        // Verificar se a tabela do time existe
        const tablesResult = await pool.query(`
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name = $1
        `, [timeFormatado]);

        console.log(`Resultado da verificação da tabela:`, tablesResult.rows);

        if (!tablesResult.rows.length) {
            console.log('Tabela não encontrada para o time informado.');
            return res.status(404).send('Tabela do time não encontrada');
        }

        // Buscar todos os jogos do time, seja como time da casa ou visitante
        const querySQL = `
            SELECT home_team, away_team, home_score, away_score, datahora, id 
            FROM ${timeFormatado} 
            WHERE home_team = $1 OR away_team = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 1  -- Primeiro os registros com hora
        ELSE 2  -- Depois os registros apenas com data
    END,
    -- Ordena dentro de cada grupo, garantindo que não haja NULL
    CASE
        WHEN datahora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
    END DESC
            LIMIT 10
        `;
        console.log(`Query SQL que será executada: ${querySQL}`);

        const jogosResult = await pool.query(querySQL, [time]);
        console.log(`Jogos retornados pela query:`, jogosResult.rows);

        // Contar vitórias
        let totalVitorias = 0;

        jogosResult.rows.forEach(row => {
            const { home_team, away_team, home_score, away_score } = row;

            if (home_team.toLowerCase() === time.toLowerCase()) {
                // Time é mandante
                if (parseInt(home_score, 10) > parseInt(away_score, 10)) {
                    totalVitorias++; // Vitória em casa
                }
            } else if (away_team.toLowerCase() === time.toLowerCase()) {
                // Time é visitante
                if (parseInt(away_score, 10) > parseInt(home_score, 10)) {
                    totalVitorias++; // Vitória fora de casa
                }
            }
        });

        console.log(`Total de vitórias do time ${time}: ${totalVitorias}`);

        // Retornar o total de vitórias
        res.json({ time, totalVitorias });
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
    const formattedStartDate = `${start_date}.${currentYear}`;
    const formattedEndDate = `${end_date}.${currentYear}`;

    // Log para verificar as datas enviadas
    console.log(`Data Início: ${formattedStartDate}`);
    console.log(`Data Fim: ${formattedEndDate}`);

    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const confrontationData = [];

        for (const { time_home, time_away } of oddsRows) {
            try {
                const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
                const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

                // Buscar IDs dos últimos 10 jogos do time da casa
                const homeIdsResult = await pool.query(`
                    SELECT id, datahora
                    FROM ${homeTable}
                    WHERE home_team = $1
ORDER BY 
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 1  -- Considera casos com "Após Prol." ou sem
        ELSE 2  
    END,
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 
            TO_TIMESTAMP(CONCAT('2025.', REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g')), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g'), 'DD.MM.YYYY')
    END DESC
            LIMIT 10
                `, [time_home]);

                const homeIds = homeIdsResult.rows.map(row => row.id);

                // Verificação dos IDs do time_home
                console.log(`Últimos 10 IDs (mais recentes) para o time ${time_home}:`, homeIds);
                console.log(`Total de IDs para o time ${time_home}: ${homeIds.length}`);

                // Buscar IDs dos últimos 10 jogos do time visitante
                const awayIdsResult = await pool.query(`
                    SELECT id, datahora
                    FROM ${awayTable}
                    WHERE away_team = $1
ORDER BY 
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 1  -- Considera casos com "Após Prol." ou sem
        ELSE 2  
    END,
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 
            TO_TIMESTAMP(CONCAT('2025.', REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g')), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g'), 'DD.MM.YYYY')
    END DESC
            LIMIT 10
                `, [time_away]);

                const awayIds = awayIdsResult.rows.map(row => row.id);

                // Verificação dos IDs do time_away
                console.log(`Últimos 10 IDs (mais recentes) para o time ${time_away}:`, awayIds);
                console.log(`Total de IDs para o time ${time_away}: ${awayIds.length}`);

                // Verificar se as tabelas existem
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
ORDER BY 
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 1  -- Considera casos com "Após Prol." ou sem
        ELSE 2  
    END,
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 
            TO_TIMESTAMP(CONCAT('2025.', REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g')), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g'), 'DD.MM.YYYY')
    END DESC
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

                // Função para calcular o total de vitórias de um time
                const calcularTotalVitorias = async (time) => {
                    const timeFormatado = time.toLowerCase().replace(/\s/g, '_');
                    const querySQL = `
                        SELECT home_team, away_team, home_score, away_score
                        FROM ${timeFormatado}
                        WHERE home_team = $1 OR away_team = $1
ORDER BY 
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 1  -- Considera casos com "Após Prol." ou sem
        ELSE 2  
    END,
    CASE
        WHEN datahora LIKE '__.__. __:__%' THEN 
            TO_TIMESTAMP(CONCAT('2025.', REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g')), 'YYYY.DD.MM HH24:MI')
        ELSE 
            TO_TIMESTAMP(REGEXP_REPLACE(datahora, '[^0-9.: ]', '', 'g'), 'DD.MM.YYYY')
    END DESC
            LIMIT 10
                    `;


                    const jogosResult = await pool.query(querySQL, [time]);
                    let totalVitorias = 0;

                    jogosResult.rows.forEach(row => {
                        const { home_team, away_team, home_score, away_score } = row;

                        if (home_team.toLowerCase() === time.toLowerCase()) {
                            if (parseInt(home_score, 10) > parseInt(away_score, 10)) {
                                totalVitorias++;
                            }
                        } else if (away_team.toLowerCase() === time.toLowerCase()) {
                            if (parseInt(away_score, 10) > parseInt(home_score, 10)) {
                                totalVitorias++;
                            }
                        }
                    });

                    return totalVitorias;
                };

                // Calcular o total de vitórias para time_home e time_away
                const totalVitoriasHome = await calcularTotalVitorias(time_home);
                const totalVitoriasAway = await calcularTotalVitorias(time_away);

                const homeWinPercentage = homeIds.length > 0
                    ? ((totalVitoriasHome / homeIds.length) * 100).toFixed(2)
                    : 0;

                const awayWinPercentage = awayIds.length > 0
                    ? ((totalVitoriasAway / awayIds.length) * 100).toFixed(2)
                    : 0;
                // Adicionando os dados ao confrontationData
                confrontationData.push({
                    time_home: time_home,
                    time_away: time_away,
                    home_home_wins: homeHomeWins,
                    home_away_wins: homeAwayWins,
                    away_home_wins: awayHomeWins,
                    away_away_wins: awayAwayWins,    
                    total_home_wins: homeHomeWins + homeAwayWins,
                    total_away_wins: awayHomeWins + awayAwayWins,
                    total_home_games: homeIds.length,
                    total_away_games: awayIds.length,
                    total_home_Average_Points: homeAveragePoints,
                    total_away_Average_Points: awayAveragePoints,
                    total_media_Average_Points: totalAveragePoints.toFixed(2),
                    total_home_general_wins: totalVitoriasHome, // Total de vitórias do time_home
                    total_away_general_wins: totalVitoriasAway, // Total de vitórias do time_away
                    home_win_percentage: homeWinPercentage,
                    away_win_percentage: awayWinPercentage,
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


app.get('/confrontations100', async (req, res) => {
    const { start_date, end_date } = req.query;

    if (!start_date || !end_date) {
        return res.status(400).json({ error: 'As datas de início e fim são necessárias.' });
    }

    // Adiciona o ano atual às datas
    const currentYear = new Date().getFullYear();
    const formattedStartDate = `${start_date}.${currentYear}`;
    const formattedEndDate = `${end_date}.${currentYear}`;

    // Log para verificar as datas enviadas
    console.log(`Data Início: ${formattedStartDate}`);
    console.log(`Data Fim: ${formattedEndDate}`);

    try {
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const confrontationData = [];

        for (const { time_home, time_away } of oddsRows) {
            try {
                const homeTable = time_home.toLowerCase().replace(/\s/g, '_');
                const awayTable = time_away.toLowerCase().replace(/\s/g, '_');

                // Buscar IDs dos últimos 10 jogos do time da casa
                const homeIdsResult = await pool.query(`
                    SELECT id, datahora
                    FROM ${homeTable}
                    WHERE home_team = $1
                    ORDER BY 
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 1
                            ELSE 2
                        END,
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 
                                TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
                            ELSE 
                                TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
                        END DESC
                    LIMIT 10
                `, [time_home]);

                const homeIds = homeIdsResult.rows.map(row => row.id);

                // Verificação dos IDs do time_home
                console.log(`Últimos 10 IDs (mais recentes) para o time ${time_home}:`, homeIds);
                console.log(`Total de IDs para o time ${time_home}: ${homeIds.length}`);

                // Buscar IDs dos últimos 10 jogos do time visitante
                const awayIdsResult = await pool.query(`
                    SELECT id, datahora
                    FROM ${awayTable}
                    WHERE away_team = $1
                    ORDER BY 
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 1
                            ELSE 2
                        END,
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 
                                TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
                            ELSE 
                                TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
                        END DESC
                    LIMIT 10
                `, [time_away]);

                const awayIds = awayIdsResult.rows.map(row => row.id);

                // Verificação dos IDs do time_away
                console.log(`Últimos 10 IDs (mais recentes) para o time ${time_away}:`, awayIds);
                console.log(`Total de IDs para o time ${time_away}: ${awayIds.length}`);

                // Verificar se as tabelas existem
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
                    ORDER BY 
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 1
                            ELSE 2
                        END,
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 
                                TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
                            ELSE 
                                TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
                        END DESC
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

                // Função para contar vitórias em casa e fora de casa
                const countWins = (rows, teamType) => {
                    const homeWins = rows.filter(row =>
                        parseInt(row.home_score, 10) > parseInt(row.away_score, 10) // Vitória em casa
                    ).length;

                    const awayWins = rows.filter(row =>
                        parseInt(row.away_score, 10) > parseInt(row.home_score, 10) // Vitória fora de casa
                    ).length;

                    return { homeWins, awayWins };
                };

                // Consulta para o time_home
                const homeResults = await pool.query(`
                    SELECT id, home_score, away_score, datahora 
                    FROM ${homeTable}
                    WHERE id = ANY($1::int[])
                    ORDER BY 
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 1
                            ELSE 2
                        END,
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 
                                TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
                            ELSE 
                                TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
                        END DESC
                    LIMIT 10
                `, [homeIds]);

                const homeIds1 = homeResults.rows.map(row => row.id);

                // Verificação dos IDs do time_home
                console.log(`Últimos 10 IDs (mais recentes) para o time Casa:`, homeIds1);
                // Contar vitórias do time_home
                const homeWins = countWins(homeResults.rows, 'home');
                const totalHomeWins = homeWins.homeWins + homeWins.awayWins;

                // Consulta para o time_away
                const awayResults = await pool.query(`
                    SELECT id, home_score, away_score, datahora 
                    FROM ${awayTable}
                    WHERE id = ANY($1::int[])
                    ORDER BY 
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 1
                            ELSE 2
                        END,
                        CASE
                            WHEN datahora LIKE '__.__. __:__' THEN 
                                TO_TIMESTAMP(CONCAT('2025.', datahora), 'YYYY.DD.MM HH24:MI')
                            ELSE 
                                TO_TIMESTAMP(datahora, 'DD.MM.YYYY')
                        END DESC
                    LIMIT 10
                `, [awayIds]);

                const homeIds2 = awayResults.rows.map(row => row.id);

                // Verificação dos IDs do time_home
                console.log(`Últimos 10 IDs (mais recentes) para o time Visitante:`, homeIds2);

                // Contar vitórias do time_away
                const awayWins = countWins(awayResults.rows, 'away');
                const totalAwayWins = awayWins.homeWins + awayWins.awayWins;

                // Cálculo do homeWinPercentage e awayWinPercentage
                const homeWinPercentage = homeIds.length > 0
                    ? ((totalHomeWins / homeIds.length) * 100).toFixed(2)
                    : 0;

                const awayWinPercentage = awayIds.length > 0
                    ? ((totalAwayWins / awayIds.length) * 100).toFixed(2)
                    : 0;

                // Adicionando os dados ao confrontationData
                confrontationData.push({
                    time_home: time_home,
                    time_away: time_away,
                    home_home_wins: homeHomeWins,
                    home_away_wins: homeAwayWins,
                    away_home_wins: awayHomeWins,
                    away_away_wins: awayAwayWins,    
                    total_home_wins: homeHomeWins + homeAwayWins,
                    total_away_wins: awayHomeWins + awayAwayWins,
                    total_home_general_wins: totalHomeWins,
                    total_away_general_wins: totalAwayWins,
                    home_win_percentage: homeWinPercentage,
                    away_win_percentage: awayWinPercentage,
                    total_home_games: homeIds.length,
                    total_away_games: awayIds.length,
                    total_home_Average_Points: homeAveragePoints,
                    total_away_Average_Points: awayAveragePoints,
                    total_media_Average_Points: totalAveragePoints.toFixed(2),
                });

                // Verificação dos totais de vitórias
                console.log(`Total de vitórias do time ${time_home}: ${totalHomeWins}`);
                console.log(`Total de vitórias do time ${time_away}: ${totalAwayWins}`);
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


app.get('/jogadoresnbatempo', async (req, res) => {
    try {
        // Buscar os jogos de odds para obter os times
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        const results = [];

        // Percorrer os jogos e calcular as médias
        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            // Consulta para os 5 melhores jogadores do time da casa
            const homeQuery = `
                SELECT 
                    player_name, 
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(points AS FLOAT)) AS avg_points
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_minutes_played DESC
                LIMIT 5;
            `;

            // Consulta para os 5 melhores jogadores do time visitante
            const awayQuery = `
                SELECT 
                    player_name, 
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(points AS FLOAT)) AS avg_points
                FROM "${awayTable}"
                GROUP BY player_name
                ORDER BY avg_minutes_played DESC
                LIMIT 5;
            `;

            // Executar as consultas
            const [homePlayersResult, awayPlayersResult] = await Promise.all([
                pool.query(homeQuery),
                pool.query(awayQuery),
            ]);

            // Adicionar resultados ao array
            results.push({
                homeTeam: time_home,
                topHomePlayers: homePlayersResult.rows.map(player => ({
                    player_name: player.player_name,
                    avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),  // Convertendo para horas
                    avg_points: player.avg_points
                })),
                awayTeam: time_away,
                topAwayPlayers: awayPlayersResult.rows.map(player => ({
                    player_name: player.player_name,
                    avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),  // Convertendo para horas
                    avg_points: player.avg_points
                })),
            });
            
            
        }

        // Enviar resposta
        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});

app.get('/jogadorespontos', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked 
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_points DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT 
                    player_name, 
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked
                FROM "${awayTable}"
                GROUP BY player_name
                ORDER BY avg_points DESC
                LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_points: player.avg_points
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_points: player.avg_points
                    })),
                });
            } catch (queryError) {
                // Log específico para tabelas faltantes
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});

app.get('/jogadorespra', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked,
                    AVG(CAST(points AS FLOAT)) +
                    AVG(CAST(total_rebounds AS FLOAT)) +
                    AVG(CAST(assists AS FLOAT)) +
                    AVG(CAST(steals AS FLOAT)) +
                    AVG(CAST(shots_blocked AS FLOAT)) AS total_contribution
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY total_contribution DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT 
                    player_name, 
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked,
                    AVG(CAST(points AS FLOAT)) +
                    AVG(CAST(total_rebounds AS FLOAT)) +
                    AVG(CAST(assists AS FLOAT)) +
                    AVG(CAST(steals AS FLOAT)) +
                    AVG(CAST(shots_blocked AS FLOAT)) AS total_contribution
                FROM "${awayTable}"
                GROUP BY player_name
                ORDER BY total_contribution DESC
                LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_points: player.avg_points,
                        avg_total_rebounds: player.avg_total_rebounds,
                        avg_assists: player.avg_assists,
                        avg_steals: player.avg_steals,
                        avg_shots_blocked: player.avg_shots_blocked,
                        total_contribution: player.total_contribution
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_points: player.avg_points,
                        avg_total_rebounds: player.avg_total_rebounds,
                        avg_assists: player.avg_assists,
                        avg_steals: player.avg_steals,
                        avg_shots_blocked: player.avg_shots_blocked,
                        total_contribution: player.total_contribution
                    })),
                });
            } catch (queryError) {
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});

app.get('/jogadoresprarb', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked,
                    AVG(CAST(points AS FLOAT)) +
                    AVG(CAST(total_rebounds AS FLOAT)) +
                    AVG(CAST(assists AS FLOAT)) +
                    AVG(CAST(steals AS FLOAT)) +
                    AVG(CAST(shots_blocked AS FLOAT)) AS total_contribution
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY total_contribution DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT 
                    player_name, 
                    AVG(CAST(points AS FLOAT)) AS avg_points,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked,
                    AVG(CAST(points AS FLOAT)) +
                    AVG(CAST(total_rebounds AS FLOAT)) +
                    AVG(CAST(assists AS FLOAT)) +
                    AVG(CAST(steals AS FLOAT)) +
                    AVG(CAST(shots_blocked AS FLOAT)) AS total_contribution
                FROM "${awayTable}"
                GROUP BY player_name
                ORDER BY total_contribution DESC
                LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        total_contribution: player.total_contribution,
                        team: time_home  // Adiciona o nome do time ao jogador
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        total_contribution: player.total_contribution,
                        team: time_away  // Adiciona o nome do time ao jogador
                    })),
                });
                
            } catch (queryError) {
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});

app.get('/jogadoresassistencias', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(assists AS FLOAT)) AS avg_assists
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_assists DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT
                player_name,
                AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                AVG(CAST(assists AS FLOAT)) AS avg_assists
            FROM "${awayTable}"
            GROUP BY player_name
            ORDER BY avg_assists DESC
            LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_assists: player.avg_assists
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_assists: player.avg_assists
                    })),
                });
            } catch (queryError) {
                // Log específico para tabelas faltantes
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});


app.get('/jogadoresrebotes', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_total_rebounds DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT
                player_name,
                AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                AVG(CAST(total_rebounds AS FLOAT)) AS avg_total_rebounds
            FROM "${awayTable}"
            GROUP BY player_name
            ORDER BY avg_total_rebounds DESC
            LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_total_rebounds: player.avg_total_rebounds
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_total_rebounds: player.avg_total_rebounds
                    })),
                });
            } catch (queryError) {
                // Log específico para tabelas faltantes
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});


app.get('/jogadoresroubos', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(steals AS FLOAT)) AS avg_steals
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_steals DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT
                player_name,
                AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                AVG(CAST(steals AS FLOAT)) AS avg_steals
            FROM "${awayTable}"
            GROUP BY player_name
            ORDER BY avg_steals DESC
            LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_steals: player.avg_steals
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_steals: player.avg_steals
                    })),
                });
            } catch (queryError) {
                // Log específico para tabelas faltantes
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});

app.get('/jogadoresbloqueios', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_jogadores';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_jogadores';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            const homeQuery = `
                SELECT 
                    player_name,
                    AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                    AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked
                FROM "${homeTable}"
                GROUP BY player_name
                ORDER BY avg_shots_blocked DESC
                LIMIT 5;
            `;
            const awayQuery = `
                SELECT
                player_name,
                AVG(CAST(minutes_played AS FLOAT)) AS avg_minutes_played,
                AVG(CAST(shots_blocked AS FLOAT)) AS avg_shots_blocked
            FROM "${awayTable}"
            GROUP BY player_name
            ORDER BY avg_shots_blocked DESC
            LIMIT 5;
            `;

            try {
                console.log('Executando consultas SQL...');
                const [homePlayersResult, awayPlayersResult] = await Promise.all([
                    pool.query(homeQuery),
                    pool.query(awayQuery),
                ]);

                console.log('Resultado da consulta home:', homePlayersResult.rows);
                console.log('Resultado da consulta away:', awayPlayersResult.rows);

                results.push({
                    homeTeam: time_home,
                    topHomePlayers: homePlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_shots_blocked: player.avg_shots_blocked
                    })),
                    awayTeam: time_away,
                    topAwayPlayers: awayPlayersResult.rows.map(player => ({
                        player_name: player.player_name,
                        avg_minutes_played: (player.avg_minutes_played / 60).toFixed(2),
                        avg_shots_blocked: player.avg_shots_blocked
                    })),
                });
            } catch (queryError) {
                // Log específico para tabelas faltantes
                console.error(
                    `Erro ao consultar dados para as tabelas: ${homeTable} ou ${awayTable}. Verifique os dados do time ${time_home} ou ${time_away}.`
                );
                console.error(queryError.message);
            }
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados:', error);
        res.status(500).send('Erro ao buscar dados.');
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
  
// Endpoint para buscar os dados da tabela nba_classificacao
app.get('/nba-classificacao', async (req, res) => {
    try {
        // Busca os dados da tabela "nba_classificacao" organizados por conferência e rank
// Consulta para os times do Oeste (id 1 a 15)
const westResult = await pool.query(`
    SELECT rank, team_name 
    FROM nba_classificacao 
    WHERE id >= 1 AND id <= 15
    ORDER BY rank ASC
`);

// Consulta para os times do Leste (id 16 a 30)
const eastResult = await pool.query(`
    SELECT rank, team_name 
    FROM nba_classificacao 
    WHERE id >= 16 AND id <= 30
    ORDER BY rank ASC
`);


        // Organiza os dados em conferências
        const results = {
            west: westResult.rows,
            east: eastResult.rows,
        };

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar dados da classificação:', error);
        res.status(500).json({ error: 'Erro ao buscar dados' });
    }
});

// Rota para buscar jogadores lesionados
app.get('/jogadoreslesionados', async (req, res) => {
    try {
        console.log('Iniciando a busca dos jogadores lesionados...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_lesoes';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_lesoes';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            // Função para verificar se a tabela existe
            const checkTableExists = async (tableName) => {
                const query = `
                    SELECT EXISTS (
                        SELECT 1
                        FROM information_schema.tables
                        WHERE table_name = '${tableName}'
                    )
                `;
                const result = await pool.query(query);
                return result.rows[0].exists;
            };

            // Verificar se as tabelas existem
            const homeTableExists = await checkTableExists(homeTable);
            const awayTableExists = await checkTableExists(awayTable);

            // Se uma das tabelas não existir, pular esse jogo
            if (!homeTableExists || !awayTableExists) {
                console.log(`Uma ou ambas as tabelas não existem: ${homeTable}, ${awayTable}. Pulando jogo.`);
                continue; // Pula para o próximo jogo
            }

            // Consulta para os jogadores lesionados em cada time
            const homeQuery = `
                SELECT player_name
                FROM "${homeTable}"
            `;
            const awayQuery = `
                SELECT player_name
                FROM "${awayTable}"
            `;

            // Executa as consultas
            const homeResult = await pool.query(homeQuery);
            const awayResult = await pool.query(awayQuery);



            const homePlayers = homeResult.rows.map(row => row.player_name);
            const awayPlayers = awayResult.rows.map(row => row.player_name);

            // Adiciona os resultados ao array
            results.push({
                team_home: time_home,
                team_away: time_away,
                homePlayers: homePlayers,
                awayPlayers: awayPlayers
            });
        }

        // Enviar os resultados ou resposta
        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar jogadores lesionados:', error);
        res.status(500).send('Erro ao buscar dados dos jogadores lesionados.');
    }
});

// Rota para buscar quantidade de jogadores lesionados
app.get('/jogadoreslesionados/contagem', async (req, res) => {
    try {
        console.log('Iniciando a busca das quantidades de jogadores lesionados...');
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;
        console.log('Odds encontradas:', oddsRows);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_') + '_lesoes';
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_') + '_lesoes';

            console.log(`Consultando tabelas: ${homeTable}, ${awayTable}`);

            // Função para verificar se a tabela existe
            const checkTableExists = async (tableName) => {
                const query = `
                    SELECT EXISTS (
                        SELECT 1
                        FROM information_schema.tables
                        WHERE table_name = '${tableName}'
                    )
                `;
                const result = await pool.query(query);
                return result.rows[0].exists;
            };

            const homeTableExists = await checkTableExists(homeTable);
            const awayTableExists = await checkTableExists(awayTable);

            if (!homeTableExists || !awayTableExists) {
                console.log(`Uma ou ambas as tabelas não existem: ${homeTable}, ${awayTable}. Pulando jogo.`);
                continue;
            }

            // Consulta para a contagem de jogadores lesionados em cada time
            const homeCountQuery = `
                SELECT COUNT(*) as count
                FROM "${homeTable}"
            `;
            const awayCountQuery = `
                SELECT COUNT(*) as count
                FROM "${awayTable}"
            `;

            const homeCountResult = await pool.query(homeCountQuery);
            const awayCountResult = await pool.query(awayCountQuery);

            const homeCount = homeCountResult.rows[0].count;
            const awayCount = awayCountResult.rows[0].count;

            results.push({
                team_home: time_home,
                team_away: time_away,
                homeInjuredCount: homeCount,
                awayInjuredCount: awayCount
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao buscar contagem de jogadores lesionados:', error);
        res.status(500).send('Erro ao buscar dados.');
    }
});


// Atualizar a banca
app.post('/update-bankroll', async (req, res) => {
    const { user_id, new_balance } = req.body;
    try {
        const query = 'UPDATE bankrolls SET balance = $1, last_update = NOW() WHERE user_id = $2 RETURNING *';
        const values = [new_balance, user_id];
        const result = await pool.query(query, values);
        
        if (result.rows.length > 0) {
            res.json({ message: 'Banca atualizada com sucesso', data: result.rows[0] });
        } else {
            res.status(404).json({ message: 'Usuário não encontrado' });
        }
    } catch (error) {
        console.error('Erro ao atualizar a banca:', error);
        res.status(500).json({ message: 'Erro interno no servidor' });
    }
});

// Middleware
app.use(cors());
app.use(bodyParser.json());

const { parse, format } = require('date-fns'); // Importa date-fns para manipulação de datas

// Função para converter data para o formato ISO aceito pelo PostgreSQL
const formatDateToISO = (dateString) => {
    // Converte "28/12/2024, 20:00" para "2024-12-28 20:00:00"
    const parsedDate = parse(dateString, "dd/MM/yyyy, HH:mm", new Date());
    return format(parsedDate, "yyyy-MM-dd HH:mm:ss");
};

// Rota para salvar uma aposta no banco de dados
// Rota para salvar uma aposta no banco de dados
app.post('/save-bet', async (req, res) => {
    const { user_id, game_date, home_team, away_team, bet_choice, odds, bet_value, Lucro, outcome } = req.body;

    try {
        // Formata a data antes de enviar para o banco de dados

        console.log('game_date recebido:', game_date);
        const formattedGameDate = formatDateToISO(game_date);

        // Insere a aposta no banco de dados
        const result = await pool.query(
            `INSERT INTO bets (user_id, game_date, home_team, away_team, bet_choice, odds, bet_value, Lucro, outcome, created_at) 
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW()) RETURNING *`,
            [user_id, formattedGameDate, home_team, away_team, bet_choice, odds, bet_value, Lucro, outcome]
        );
        
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error('Erro ao salvar aposta:', err);
        res.status(500).json({ error: 'Erro ao salvar aposta' });
    }
});
// Rota para atualizar o status da aposta (Vencedor ou Perdeu)
// Rota para atualizar o resultado da aposta
app.put('/update-bet-outcome/:id', async (req, res) => {
    const { id } = req.params; // ID da aposta
    const { outcome } = req.body; // Novo status ("Vencedor" ou "Perdeu")

    try {
        const result = await pool.query(
            `UPDATE bets SET outcome = $1, updated_at = NOW() WHERE id = $2 RETURNING *`,
            [outcome, id]
        );

        if (result.rowCount === 0) {
            return res.status(404).json({ error: 'Aposta não encontrada' });
        }

        res.json(result.rows[0]); // Retorna a aposta atualizada
    } catch (err) {
        console.error('Erro ao atualizar o resultado da aposta:', err);
        res.status(500).json({ error: 'Erro ao atualizar o resultado da aposta' });
    }
});

app.post('/save-bet-history', async (req, res) => {
    const { user_id, game_date, games, choices, odds, bet_value, Lucro, outcome } = req.body;

    try {
        // Insere os dados diretamente no banco de dados
        const result = await pool.query(
            `INSERT INTO bets (user_id, game_date, games, choices, odds, bet_value, Lucro, outcome, created_at) 
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW()) RETURNING *`,
            [user_id, game_date, games, choices, odds, bet_value, Lucro, outcome]
        );

        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error('Erro ao salvar aposta:', err); // Log completo do erro no console do backend
        res.status(500).json({ 
            error: 'Erro ao salvar aposta', 
            details: err.message // Retorna detalhes do erro para debug
        });
    }
});


app.get('/bets/history', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM bets ORDER BY created_at DESC');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Erro ao buscar histórico' });
    }
});


// Rota para registro de usuário
app.post('/register', async (req, res) => {
    const { username, email, password, balance } = req.body;

    try {
        // Verifica se o usuário já existe
        const result = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        if (result.rows.length > 0) {
            return res.status(400).json({ error: 'Usuário já existe.' });
        }

        // Criptografa a senha
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insere o novo usuário no banco de dados
        const insertResult = await pool.query(
            'INSERT INTO users (username, email, password) VALUES ($1, $2, $3) RETURNING id',
            [username, email, hashedPassword]
        );

        const userId = insertResult.rows[0].id;

        // Insere a banca inicial do usuário, usando o valor fornecido pelo usuário
        await pool.query(
            'INSERT INTO bankrolls (user_id, balance) VALUES ($1, $2)', 
            [userId, balance]  // O valor da banca é agora o valor enviado pelo usuário
        );

        res.status(201).json({ userId }); // Retorna o userId
    } catch (error) {
        console.error('Erro ao registrar usuário:', error);
        res.status(500).json({ error: 'Erro interno do servidor.' });
    }
});


// Endpoint de Login
// Endpoint de Login
// Endpoint de Login
app.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        // Verifica se o usuário existe no banco de dados
        const userResult = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        const user = userResult.rows[0];

        // Verifica se o usuário foi encontrado e se a senha está correta
        if (!user || !(await bcrypt.compare(password, user.password))) {
            return res.status(401).json({ message: 'Credenciais inválidas!' });
        }

        // Busca o saldo do usuário na tabela bankrolls
        const bankrollResult = await pool.query('SELECT balance FROM bankrolls WHERE user_id = $1', [user.id]);
        const balance = bankrollResult.rows[0]?.balance || 0; // Padrão para 0 se não houver registro

        // Gerar o token JWT
        const token = jwt.sign({ userId: user.id, email: user.email }, 'seu-segredo-aqui', { expiresIn: '1h' });
        // Logar o token gerado para verificação
        console.log('Token gerado:', token);  // Aqui o token será impresso no console

        // Retornar o token e informações adicionais para o cliente
        res.json({ token, username: user.username, balance });
    } catch (error) {
        console.error('Erro ao fazer login:', error);
        res.status(500).json({ message: 'Erro interno no servidor' });
    }
});

// Middleware para verificar o token JWT
// Middleware para autenticar o token JWT
function authenticateToken(req, res, next) {
    const token = req.headers['authorization'] && req.headers['authorization'].split(' ')[1]; // "Bearer <token>"

    if (!token) {
        return res.status(403).json({ message: 'Token não fornecido!' });
    }

    jwt.verify(token, 'seu-segredo-aqui', (err, user) => {
        if (err) {
            console.log("Erro ao verificar o token:", err);

            if (err.name === 'TokenExpiredError') {
                console.log("Token expirado, gerando novo token...");

                // Decodifica o token para obter as informações do usuário
                const decoded = jwt.decode(token);
                if (!decoded) {
                    return res.status(403).json({ message: 'Token inválido!' });
                }

                // Gere um novo token usando os dados do token decodificado
                const newToken = generateToken(decoded.userId, decoded.email);
                return res.status(401).json({ message: 'Token expirado', newToken });
            }

            return res.status(403).json({ message: 'Token inválido!' });
        }

        req.userId = user.userId; // Adiciona o userId à requisição
        next();
    });
}


app.use(authenticateToken); // Aplica o middleware a todas as rotas protegidas



app.post('/save-planning', authenticateToken, async (req, res) => {
    const { daysOption, days, bankroll, targetProfit } = req.body;
    const userId = req.userId; // O ID do usuário é extraído do token

    try {
        // Verifica se já existe um planejamento de apostas para esse usuário
        const existingPlan = await pool.query('SELECT * FROM betting_plans WHERE user_id = $1', [userId]);

        if (existingPlan.rows.length > 0) {
            // Atualiza o planejamento existente
            await pool.query(
                'UPDATE betting_plans SET days_option = $1, days = $2, bankroll = $3, target_profit = $4 WHERE user_id = $5',
                [daysOption, days, bankroll, targetProfit, userId]
            );
        } else {
            // Cria um novo planejamento
            await pool.query(
                'INSERT INTO betting_plans (user_id, days_option, days, bankroll, target_profit) VALUES ($1, $2, $3, $4, $5)',
                [userId, daysOption, days, bankroll, targetProfit]
            );
        }

        res.json({ message: 'Planejamento salvo com sucesso!' });
    } catch (error) {
        console.error('Erro ao salvar o planejamento:', error);
        res.status(500).json({ message: 'Erro interno ao salvar planejamento.' });
    }
});


// Rota para buscar o planejamento de apostas do usuário
app.get('/get-planning', authenticateToken, async (req, res) => {
    const userId = req.userId; // Obtém o userId do token

    try {
        const result = await pool.query(
            `SELECT days_option, days, bankroll, target_profit 
             FROM betting_plans 
             WHERE user_id = $1`,
            [userId]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Planejamento de apostas não encontrado.' });
        }

        // Retorna os dados encontrados para o frontend
        res.status(200).json(result.rows[0]);
    } catch (error) {
        console.error('Erro ao buscar planejamento de apostas:', error);
        res.status(500).json({ message: 'Erro ao buscar planejamento de apostas.' });
    }
});








app.get('/user', async (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1];

    if (!token) return res.status(401).json({ message: 'Token não fornecido' });

    try {
        const decoded = jwt.verify(token, 'seu-segredo-aqui');
        const userId = decoded.userId;

        const bankrollResult = await pool.query('SELECT balance FROM bankrolls WHERE user_id = $1', [userId]);
        const balance = bankrollResult.rows[0]?.balance || 0;

        res.json({ balance });
    } catch (error) {
        console.error('Erro ao buscar informações do usuário:', error);
        res.status(401).json({ message: 'Token inválido ou expirado' });
    }
});



// Endpoint de exemplo para dados protegidos
app.get('/protected', (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1];  // Pega o token do cabeçalho 'Authorization'

    if (!token) {
        return res.status(403).json({ message: 'Token não fornecido!' });
    }

    // Verificar e decodificar o token
    jwt.verify(token, 'seu-segredo-aqui', (err, decoded) => {
        if (err) {
            return res.status(401).json({ message: 'Token inválido!' });
        }

        // Se o token for válido, retornar dados protegidos
        res.json({ message: 'Dados protegidos', userId: decoded.userId, email: decoded.email });
    });
});

app.get('/get-bet-history', async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) return res.status(403).json({ message: 'Token não fornecido!' });

    try {
        const decoded = jwt.verify(token, 'seu-segredo-aqui');
        const userId = decoded.userId;

        const result = await pool.query('SELECT * FROM bets WHERE user_id = $1 ORDER BY game_date DESC', [userId]);
        res.json({ bets: result.rows });
    } catch (error) {
        console.error('Erro ao buscar histórico de apostas:', error);
        res.status(500).json({ message: 'Erro interno no servidor' });
    }
});

app.get('/get-bankroll', async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) return res.status(403).json({ message: 'Token não fornecido!' });

    try {
        const decoded = jwt.verify(token, 'seu-segredo-aqui');
        const userId = decoded.userId;

        const result = await pool.query('SELECT balance FROM bankrolls WHERE user_id = $1', [userId]);
        if (result.rows.length > 0) {
            res.json({ balance: result.rows[0].balance });
        } else {
            res.status(404).json({ message: 'Banca não encontrada!' });
        }
    } catch (error) {
        console.error('Erro ao buscar banca:', error);
        res.status(500).json({ message: 'Erro interno no servidor' });
    }
});

app.post('/startrender', (req, res) => {
    const executorPath = path.join(__dirname, 'executor.js');
    exec(`node ${executorPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erro ao executar o script executor: ${error.message}`);
            return res.status(500).send('Erro ao executar o script executor.');
        }
        if (stderr) {
            console.error(`Erro no script executor: ${stderr}`);
            return res.status(500).send('Erro ao executar o script executor.');
        }
        console.log(`Resultado do script executor: ${stdout}`);
        res.send('Script executor executado com sucesso.');
    });
});


// Rota para salvar os dados no banco de dados
app.post('/save-odds', async (req, res) => {
    console.log('Requisição recebida em /save-odds');
    console.log('Corpo da requisição:', req.body);

    // Confirma se a requisição possui todos os dados necessários
    const { dataJogo, timeHome, timeAway, homeOdds, awayOdds, overDoisMeioOdds, overOdds } = req.body;

    if (!dataJogo || !timeHome || !timeAway || isNaN(homeOdds) || isNaN(awayOdds) || isNaN(overDoisMeioOdds) || isNaN(overOdds)) {
        console.log('Erro: Dados incompletos na requisição');
        return res.status(400).json({ success: false, message: 'Dados incompletos' });
    }

    console.log('Dados recebidos estão completos. Preparando para salvar no banco de dados.');
    console.log('Dados a serem inseridos:', { dataJogo, timeHome, timeAway, homeOdds, awayOdds, overDoisMeioOdds, overOdds });

    // Sua lógica de inserção no banco de dados
    const queryText = `
        INSERT INTO odds (data_jogo, time_home, time_away, home_odds, away_odds, over_dois_meio, over_odds)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING id;
    `;

    try {
        console.log('Executando a query no banco de dados...');
        const result = await pool.query(queryText, [
            dataJogo, timeHome, timeAway, homeOdds, awayOdds, overDoisMeioOdds, overOdds
        ]);

        const insertedId = result.rows[0].id;
        console.log('Dados salvos com sucesso. ID inserido:', insertedId);

        res.status(200).json({ success: true, id: insertedId });
    } catch (error) {
        console.error('Erro ao salvar no banco de dados:', error);
        res.status(500).json({ success: false, error: error.message });
    }
});

// Servir arquivos estáticos da pasta 'public'
app.use(express.static(path.join(__dirname, 'public')));

// Iniciar o servidor
app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}/`);
});

