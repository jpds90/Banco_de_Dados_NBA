require('dotenv').config();
const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração do pool de conexão ao banco de dados
const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});

// Função para tentar navegar com tentativas de re-execução
const loadPageWithRetries = async (page, url, retries = 3) => {
  for (let attempt = 0; attempt < retries; attempt++) {
    try {
      console.log(`Tentativa ${attempt + 1} de carregar a página: ${url}`);
      await page.goto(url, { timeout: 120000, waitUntil: 'domcontentloaded' });
      console.log("Página carregada com sucesso.");
      return;
    } catch (error) {
      console.error(`Erro ao carregar a página na tentativa ${attempt + 1}:`, error.message);
      if (attempt === retries - 1) throw error; // Lançar o erro na última tentativa
    }
  }
};

// Função para criar a tabela de jogadores para o time
const createPlayersTable = async (teamName) => {
  const client = await pool.connect();
  try {
    const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();

    console.log(`Verificando a criação da tabela "jogadores" para o time: "${teamName}"...`);

    await client.query(`
      DROP TABLE IF EXISTS "${tableName}_lesoes";
    `);
    await client.query(`
      CREATE TABLE IF NOT EXISTS "${tableName}_lesoes" (
          id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
          player_name VARCHAR(255) NOT NULL,
          injury_status VARCHAR(255),
          date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);
    console.log(`Tabela de lesões criada para o time: "${teamName}".`);
  } catch (error) {
    console.error(`Erro ao criar tabela de lesões para o time "${teamName}":`, error);
  } finally {
    client.release();
  }
};

// Função para salvar os dados das lesões no banco
const saveInjuriesToDatabase = async (teamName, players) => {
  const client = await pool.connect();
  try {
    const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();
    console.log(`Salvando lesões dos jogadores na tabela "${tableName}_lesoes"...`);

    for (const player of players) {
      const { name, injury } = player;
      // Insere o jogador com a lesão, se houver
      await client.query(
        `INSERT INTO "${tableName}_lesoes" (player_name, injury_status) VALUES ($1, $2)`,
        [name, injury || 'Nenhuma lesão']
      );
      console.log(`Lesão salva para o jogador: ${name}`);
    }
  } catch (error) {
    console.error(`Erro ao salvar lesões na tabela "${tableName}_lesoes":`, error);
  } finally {
    client.release();
  }
};

// Função para buscar links da tabela 'links'
const fetchLinksFromDatabase = async () => {
  const client = await pool.connect();
  try {
    console.log('Buscando todos os links da tabela "links"...');
    const result = await client.query('SELECT link FROM links');
    if (result.rows.length > 0) {
      console.log(`${result.rows.length} links encontrados no banco de dados.`);
      return result.rows.map(row => row.link);
    } else {
      console.log('Nenhum link encontrado na tabela "links".');
      return [];
    }
  } catch (error) {
    console.error('Erro ao buscar links no banco de dados:', error);
    return [];
  } finally {
    client.release();
  }
};

// Scraping do site
const scrapeResults3 = async (link) => {
  const data = [];
  console.log(`Iniciando o scraping para o link: ${link}`);

  const fullLink = `${link}resultados/`;
  console.log('Link completo para scraping:', fullLink);

  const browser = await puppeteer.launch({
    headless: true, // Garante que o navegador rode em modo headless
    args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições no ambiente do Render
  });
  const page = await browser.newPage();
  console.log('Abrindo o navegador e indo para a página...', fullLink);
  await loadPageWithRetries(page, fullLink);

  const url = await page.evaluate(() => window.location.href);

  // Espera pela tabela de classificação carregar
  await sleep(5000);
  await page.waitForSelector('.lineupTable--basketball', { timeout: 90000 });

  // Extrai o texto dentro dos seletores
  const players = await page.evaluate(() => {
    const playerElements = Array.from(document.querySelectorAll('.lineupTable--basketball .lineupTable__cell--nameAndAbsence'));
    const playerData = [];

    playerElements.forEach(element => {
      // Verifica se há uma lesão no jogador
      const injuryElement = element.querySelector('svg');
      const playerName = element.querySelector('a').textContent.trim();
      let injuryStatus = null;

      // Se o jogador tiver uma lesão, extrai o nome da lesão do <title> dentro do <svg>
      if (injuryElement) {
        const injuryTitle = injuryElement.querySelector('title');
        if (injuryTitle) {
          injuryStatus = injuryTitle.textContent.trim(); // Lesão
        }
      }

      // Adiciona o jogador com o nome da lesão (se houver)
      playerData.push({ name: playerName, injury: injuryStatus });
    });

    return playerData;
  });

  // Exibe os resultados
  console.log(players);

  // Fecha o navegador
  await browser.close();

  // Extrai o nome do time do link
  const rawTeamName = link.split('/').slice(-3, -2)[0]; // Obtém o nome bruto do time
  const teamName = rawTeamName.replace('-', ' '); // Formata para exibição (ex.: "los angeles-lakers" -> "los angeles lakers")
  const normalizedTeamName = rawTeamName.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase(); // Normaliza para uso no banco (ex.: "los angeles-lakers" -> "los_angeles_lakers")

  console.log(`Time identificado a partir do link: ${teamName}`);

  // Cria a tabela de lesões e salva os dados no banco de dados
  await createPlayersTable(normalizedTeamName); // Cria a tabela para os jogadores
  await saveInjuriesToDatabase(normalizedTeamName, players); // Salva os dados das lesões dos jogadores

  console.log(`Scraping finalizado para o link: ${link}`);
};

// Função principal
if (require.main === module) {
  (async () => {
    try {
      console.log("Executando script.js...");

      const links = await fetchLinksFromDatabase();

      // Log dos links no console
      console.log('Links obtidos do banco de dados:', links);

      if (links.length === 0) {
        console.log('Nenhum link encontrado para processamento.');
        process.exit(0); // Nada a fazer, mas encerra com sucesso
      }

      for (const link of links) {
        console.log(`Iniciando o scraping para o link: ${link}`);
        await scrapeResults3(link);
      }

      console.log('Processo de scraping completo!');
      process.exit(0); // Indicar sucesso
    } catch (error) {
      console.error("Erro em script.js:", error);
      process.exit(1); // Indicar falha
    }
  })();
}


// Exporta a função de scraping
module.exports = { scrapeResults3 };
