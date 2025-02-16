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

    const client = await pool.connect();

    try {
        // 🔎 Verifica se a URL já existe na tabela
        const checkExistence = await client.query(`SELECT * FROM ${tableName} WHERE link = $1`, [url]);

        if (checkExistence.rows.length > 0) {
            console.log(`🔄 URL já existe na tabela ${tableName}: ${url}`);
            return res.json({ success: false, message: "URL já está salva!" });
        }

        // 💾 Se a URL não existir, insere no banco
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
    const scriptPath = path.join(__dirname, 'public', 'linksfutebol.js');
    runScript(scriptPath, res, 'Extrair URL dos Times');
});


app.post('/timefutebol', async (req, res) => {
    const { tableName } = req.body;
    console.log(`🔍 Recebido tableName: ${tableName}`);

    try {
        const links = await fetchLinksFromDatabase1(tableName);

        console.log("📤 Enviando links para o frontend:", links);  // 🔥 Adicione isso

        res.json(links);
    } catch (error) {
        console.error("❌ Erro ao buscar links:", error);
        res.status(500).send('Erro ao buscar os links');
    }
});



// Rota para executar o script oddsfutebol.js
app.post('/oddsfutebol', (req, res) => {
    const scriptPath = path.join(__dirname, 'public', 'oddsfutebol.js');
    runScript(scriptPath, res, 'Extrair os confrontos');
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

app.get('/confrontosfutebol', async (req, res) => {
    try {
        // Captura o nome da tabela da query string
        const tableName = req.query.tableName || 'odds';

        // Log para verificar se o tableName está chegando corretamente
        console.log(`📌 Nome da tabela recebida: ${tableName}`);

        // Buscar os jogos da tabela especificada
        const oddsResult = await pool.query(`SELECT time_home, time_away FROM ${tableName}`);
        const oddsRows = oddsResult.rows;

        console.log(`🔍 Registros encontrados: ${oddsRows.length}`);

        const results = [];

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";

            const confrontationResult = await pool.query(`
                SELECT resultadohome, resultadoaway, timehome, timeaway
                FROM ${homeTable}
                WHERE (timehome = $1 AND timeaway = $2)
                   OR (timehome = $2 AND timeaway = $1)
                ORDER BY id ASC
            `, [time_home, time_away]);

            const confrontations = confrontationResult.rows;

            let totalHomePoints = 0;
            let totalAwayPoints = 0;

            confrontations.forEach(row => {
                totalHomePoints += parseInt(row.resultadohome, 10) || 0;
                totalAwayPoints += parseInt(row.resultadoaway, 10) || 0;
            });

            const homeAveragePoints = confrontations.length > 0
                ? Math.round(totalHomePoints / confrontations.length)
                : 0;

            const awayAveragePoints = confrontations.length > 0
                ? Math.round(totalAwayPoints / confrontations.length)
                : 0;

            const totalPoints = confrontations.length > 0
                ? Math.round((totalHomePoints + totalAwayPoints) / confrontations.length)
                : 0;

            // Converter para inteiro
            const formatPoints = (points) => points === 0 ? '0' : points;

            results.push({
                timehome: time_home,
                timeaway: time_away,
                home_average_points: formatPoints(homeAveragePoints),
                away_average_points: formatPoints(awayAveragePoints),
                total_points: formatPoints(totalPoints)
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});



app.get('/probabilidade-vitoria', async (req, res) => {
  try {
    console.log("Recebendo requisição para /probabilidade-vitoria");
    
    const { tableName } = req.query;
    console.log("Parâmetro recebido - tableName:", tableName);

    // Validação para garantir que tableName não está vazio
    if (!tableName) {
      console.error("Erro: Nome da tabela não fornecido");
      return res.status(400).json({ error: 'Nome da tabela não fornecido' });
    }

    const oddsResult = await pool.query(`SELECT time_home, time_away FROM ${tableName}`);
    const oddsRows = oddsResult.rows;

    console.log(`Foram encontrados ${oddsRows.length} registros na tabela ${tableName}`);

    if (oddsRows.length === 0) {
      return res.status(404).json({ error: `Nenhum jogo encontrado na tabela ${tableName}` });
    }

    const results = [];

    for (const { time_home, time_away } of oddsRows) {
      console.log(`Processando jogo: ${time_home} vs ${time_away}`);

      const homeTable = time_home.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";
      const awayTable = time_away.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";

      console.log("Tabelas geradas -> homeTable:", homeTable, "| awayTable:", awayTable);

      // Buscar os dados estatísticos da tabela do time da casa (homeTable)
      const query = `
        SELECT 
          posse_de_bola, 
          tentativas_de_golo, 
          remates_a_baliza, 
          grandes_oportunidades, 
          CASE WHEN resultadohome > resultadoaway THEN 1 ELSE 0 END as vitoria
        FROM ${homeTable}
        WHERE timehome = $1 AND timeaway = $2;
      `;

      console.log("Executando query na tabela:", homeTable);
      console.log("Parâmetros -> timehome:", time_home, "| timeaway:", time_away);

      const { rows } = await pool.query(query, [time_home, time_away]);

      console.log(`Resultados encontrados: ${rows.length}`);

      if (rows.length === 0) {
        console.warn(`Nenhum dado encontrado para ${time_home} vs ${time_away} na tabela ${homeTable}`);
        continue;
      }

      // Preparação dos dados para o modelo
      const data = rows.map(row => [
        row.posse_de_bola,
        row.tentativas_de_golo,
        row.remates_a_baliza,
        row.grandes_oportunidades,
      ]);

      const labels = rows.map(row => row.vitoria);

      console.log(`Treinando modelo com ${data.length} amostras`);

      // Treinar o modelo de regressão logística
      const X = new Matrix(data);
      const y = labels;

      const logisticRegression = new LogisticRegression({ numSteps: 1000, learningRate: 0.5 });
      logisticRegression.train(X, y);

      // Fazer previsões (usando a média das features dos dados existentes)
      const meanFeatures = [
        data.reduce((sum, row) => sum + row[0], 0) / data.length,
        data.reduce((sum, row) => sum + row[1], 0) / data.length,
        data.reduce((sum, row) => sum + row[2], 0) / data.length,
        data.reduce((sum, row) => sum + row[3], 0) / data.length,
      ];

      console.log("Média das características calculada:", meanFeatures);

      const probability = logisticRegression.predictProbability(new Matrix([meanFeatures]));

      console.log(`Probabilidade de vitória calculada para ${time_home}: ${probability[0][1]}`);

      // Adiciona os resultados no array de retorno
      results.push({
        timeHome: time_home,
        timeAway: time_away,
        probabilidadeVitoria: probability[0][1], // Probabilidade de vitória (classe 1)
      });
    }

    // Retorna os resultados de todos os jogos analisados
    console.log("Finalizando requisição. Resultados:", results);
    res.json({ resultados: results });

  } catch (error) {
    console.error('Erro ao calcular a probabilidade de vitória:', error);
    res.status(500).json({ error: 'Erro interno do servidor.' });
  }
});

app.get('/golsemcasa', async (req, res) => {
    try {
        const tableName = req.query.tableName || 'odds';
        const threshold = parseFloat(req.query.threshold) || 0.5;

        console.log(`📌 Nome da tabela recebida: ${tableName}`);
        console.log(`🔍 Filtro de gol: ${threshold}`);

        const oddsResult = await pool.query(`SELECT time_home, time_away FROM ${tableName}`);
        const oddsRows = oddsResult.rows;

        console.log(`🔍 Qtd de registros encontrados: ${oddsRows.length}`);

        const results = [];
        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";
            const awayTable = time_away.toLowerCase().replace(/\s/g, '_').replace(/\./g, '') + "_futebol";

            // Verificar tabelas existentes
            const tablesResult = await pool.query(`
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_name = $1 OR table_name = $2
            `, [homeTable, awayTable]);

            const tableNames = tablesResult.rows.map(row => row.table_name);

            let homeHitsThreshold = 0;
            let awayHitsThreshold = 0;

            // Verificar se a tabela do time da casa existe e calcular as ocorrências do gol
            if (tableNames.includes(homeTable)) {
                const homeScoresResult = await pool.query(`
                    SELECT resultadohome 
                    FROM ${homeTable} 
                    WHERE timehome = $1
                    ORDER BY 
                      -- Prioriza registros no formato DD.MM. HH:MI
                      CASE
                          WHEN data_hora  LIKE '__.__. __:__' THEN 1
                          ELSE 2
                      END,
                      -- Ordena pela data/hora dentro de cada grupo de formatos
                      CASE
                          WHEN data_hora  LIKE '__.__. __:__' THEN 
                              TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                          WHEN data_hora  LIKE '__.__.____ __:__' THEN 
                              TO_TIMESTAMP(data_hora , 'DD.MM.YYYY')
                      END DESC
                    LIMIT 10
                `, [time_home]);

                const homeScores = homeScoresResult.rows
                    .map(row => parseInt(row.resultadohome, 10))
                    .filter(score => !isNaN(score) && score > threshold);

  homeAvg = homeScores.length 
      ? Math.round(homeScores.reduce((a, b) => a + b, 0) / homeScores.length) 
      : 0;
                homeHitsThreshold = homeScores.length;
            }

            // Verificar se a tabela do time visitante existe e calcular as ocorrências do gol
            if (tableNames.includes(awayTable)) {
                const awayScoresResult = await pool.query(`
                    SELECT resultadoaway 
                    FROM ${awayTable} 
                    WHERE timeaway = $1
                    ORDER BY 
                      -- Prioriza registros no formato DD.MM. HH:MI
                      CASE
                          WHEN data_hora  LIKE '__.__. __:__' THEN 1
                          ELSE 2
                      END,
                      -- Ordena pela data/hora dentro de cada grupo de formatos
                      CASE
                          WHEN data_hora  LIKE '__.__. __:__' THEN 
                              TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
                          WHEN data_hora  LIKE '__.__.____ __:__' THEN 
                              TO_TIMESTAMP(data_hora , 'DD.MM.YYYY')
                      END DESC
                    LIMIT 10
                `, [time_away]);

                const awayScores = awayScoresResult.rows
                    .map(row => parseInt(row.resultadoaway, 10))
                    .filter(score => !isNaN(score) && score > threshold);

  awayAvg = awayScores.length 
      ? Math.round(awayScores.reduce((a, b) => a + b, 0) / awayScores.length) 
      : 0;
                awayHitsThreshold = awayScores.length;
            }

            // Adicionar os resultados para enviar ao frontend
            results.push({
                time_home,
                time_away,
              home_avg: homeAvg,
              away_avg: awayAvg,
              total_pontos: homeAvg + awayAvg, // Agora ambos já são inteiros
                home_hits_threshold: homeHitsThreshold,
                away_hits_threshold: awayHitsThreshold
            });
        }

        res.json(results);
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
        res.status(500).send('Erro no servidor');
    }
});



app.get("/ultimos10jogos", async (req, res) => {
  try {
    const timeHome = req.query.timeHome;
    const timeAway = req.query.timeAway;

    if (!timeHome || !timeAway) {
      return res.status(400).json({ error: "Parâmetros 'timeHome' e 'timeAway' são obrigatórios." });
    }

    console.log(`🏠 Time mandante consultado: ${timeHome}`);
    console.log(`🚀 Time visitante consultado: ${timeAway}`);

    // Transformar nomes para formato de tabela
    const homeTable = timeHome.toLowerCase().replace(/\s/g, "_").replace(/\./g, "") + "_futebol";
    const awayTable = timeAway.toLowerCase().replace(/\s/g, "_").replace(/\./g, "") + "_futebol";

    console.log(`🏠 Tabela do time da casa: ${homeTable}`);
    console.log(`🚀 Tabela do time visitante: ${awayTable}`);

    // Buscar jogos dos dois times
    let jogos = [];

    const buscarJogos = async (table, column, team) => {
      const tablesResult = await pool.query(
        `SELECT table_name FROM information_schema.tables WHERE table_name = $1`,
        [table]
      );
      if (tablesResult.rows.length > 0) {
        const querySQL = `
          SELECT timehome, resultadohome, timeaway, resultadoaway, data_hora 
          FROM ${table} 
          WHERE ${column} = $1
ORDER BY 
    -- Prioriza registros no formato DD.MM. HH:MI
    CASE
        WHEN data_hora LIKE '__.__. __:__' THEN 1
        ELSE 2
    END,
    -- Ordena pela data/hora dentro de cada grupo de formatos
    CASE
        WHEN data_hora LIKE '__.__. __:__' THEN 
            TO_TIMESTAMP(CONCAT('2025.', data_hora), 'YYYY.DD.MM HH24:MI')
        WHEN data_hora LIKE '__.__.____ __:__' THEN 
            TO_TIMESTAMP(data_hora, 'DD.MM.YYYY')
    END DESC
          LIMIT 10
        `;

        console.log(`📄 Executando query para ${table}: ${querySQL}`);
        const jogosResult = await pool.query(querySQL, [team]);
        return jogosResult.rows;
      }
      return [];
    };

    const jogosHome = await buscarJogos(homeTable, "timehome", timeHome);
    const jogosAway = await buscarJogos(awayTable, "timeaway", timeAway);

    jogos = [...jogosHome, ...jogosAway];

    console.log(`📊 Jogos retornados pela query:`, jogos);

    const jogosFormatados = jogos.map((row) => {
      const { timehome, timeaway, resultadohome, resultadoaway, data_hora } = row;
      let timeA, timeB, pontosA, pontosB;
        
      if (timehome.toLowerCase() === timeHome.toLowerCase()) {
          // Time é mandante
          timeA = timehome; // Time do lado esquerdo
          timeB = timeaway; // Adversário
          pontosA = resultadohome; // Pontos do time mandante
          pontosB = resultadoaway; // Pontos do adversário
        } else if (timeaway.toLowerCase() === timeAway.toLowerCase()) {
          // Time é visitante
          timeB = timeaway; // Time consultado no lado direito
          timeA = timehome; // Adversário
          pontosB = resultadoaway; // Pontos do time visitante
          pontosA = resultadohome; // Pontos do adversário
      } else {
          throw new Error('O time escolhido não participou deste jogo.');
      }
  
      // Calculando o resultado baseado no time consultado
      let statusResultado;
      if (timeHome.toLowerCase() === timeA.toLowerCase() || timeAway.toLowerCase() === timeA.toLowerCase()) {
          // Time consultado é o mandante
          if (parseInt(pontosA, 10) > parseInt(pontosB, 10)) {
              statusResultado = `${timeA} ✅`; // Venceu
          } else if (parseInt(pontosA, 10) < parseInt(pontosB, 10)) {
              statusResultado = `${timeA} ❌`; // Perdeu
          } else {
              statusResultado = 'Empate';
          }
        } else if (timeHome.toLowerCase() === timeB.toLowerCase() || timeAway.toLowerCase() === timeB.toLowerCase()) {
          // Time consultado é o visitante
          if (parseInt(pontosB, 10) > parseInt(pontosA, 10)) {
              statusResultado = `${timeB} ✅`; // Venceu
          } else if (parseInt(pontosB, 10) < parseInt(pontosA, 10)) {
              statusResultado = `${timeB} ❌`; // Perdeu
          } else {
              statusResultado = 'Empate';
          }
      }

      const [data, hora] = data_hora.split(" ");
      const dataFormatada = data.replace(".", "/").slice(0, -1);

      return {
        timeA,
        timeB,
        pontosA,
        pontosB,
        resultado: statusResultado,
        data_hora: dataFormatada,
        hora,
      };
    });

    const results = jogosFormatados.filter((j) => j !== null);

    console.log("📢 Jogos processados finalizados:", results);
    res.json(results);
  } catch (error) {
    console.error("🔥 Erro ao processar os dados:", error);
    res.status(500).send("Erro no servidor");
  }
});



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
        const result = await client.query(`
            SELECT DISTINCT ON (link) team_name, link, event_time
            FROM laliga_links
            ORDER BY link, event_time DESC
        `);
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Erro ao buscar dados dos laliga_links.');
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
function runScript(scriptPath, res, scriptName) {
    exec(`node ${scriptPath}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`❌ Erro ao executar ${scriptName}: ${error.message}`);
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

