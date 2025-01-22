const puppeteer = require('puppeteer');
const { Pool } = require('pg');

// Função para tentar navegar com tentativas de re-execução
async function tryNavigate(url, page, maxRetries = 3) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            await page.goto(url, { timeout: 180000 }); // Ajustando o timeout
            return; // Se a navegação for bem-sucedida, sai da função
        } catch (error) {
            if (error.name === 'TimeoutError' && attempt < maxRetries) {
                console.log(`Timeout na tentativa ${attempt} para ${url}. Tentando novamente...`);
                await sleep(5000); // Esperar 5 segundos antes de tentar novamente
            } else {
                console.error(`Erro ao navegar para ${url} após ${maxRetries} tentativas:`, error);
                throw error; // Lança o erro se o número máximo de tentativas for atingido
            }
        }
    }
}

// Função para adicionar um atraso (sleep) entre as tentativas
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

// Configuração do pool de conexão ao banco de dados
const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});

(async () => {
  // Inicia o navegador
  const browser = await puppeteer.launch({
    headless: true, // Garante que o navegador rode em modo headless
    args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições no ambiente do Render
  });
  const page = await browser.newPage();

  // Tenta navegar para o site com re-tentativas
  await tryNavigate('https://www.flashscore.pt/basquetebol/eua/nba/classificacoes/#/nRrQOhwm/table/overall', page, 3);

  // Aguarda a tabela carregar
  await page.waitForSelector('.ui-table__body');

  // Extrai os dados dos dois primeiros elementos `.ui-table__body`
  const rows = await page.$$eval('.ui-table__body', tables => {
    // Seleciona apenas os dois primeiros `.ui-table__body`
    const selectedTables = tables.slice(0, 2);

    // Extrai as 15 primeiras linhas de cada tabela
    const allRows = selectedTables.flatMap(table => {
      const rows = Array.from(table.querySelectorAll('.ui-table__row')).slice(0, 15);
      return rows.map(row => {
        const rankText = row.querySelector('.table__cell--rank .tableCellRank')?.innerText.trim();
        const rank = rankText ? rankText.replace('.', '') : null; // Remove o ponto do número
        const teamName = row.querySelector('.tableCellParticipant__name')?.innerText.trim();
        return { rank, teamName };
      });
    });

    // Retorna apenas as linhas válidas (com rank e nome do time)
    return allRows.filter(row => row.rank && row.teamName);
  });

  console.log(rows);

// Função para salvar dados no banco de dados
const saveDataToDatabase = async (rows) => {
  const client = await pool.connect();
  try {
    // Cria a tabela caso não exista, agora utilizando GENERATED ALWAYS AS IDENTITY
    await client.query(`
      CREATE TABLE IF NOT EXISTS nba_classificacao (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        rank INTEGER NOT NULL,
        team_name VARCHAR(255) NOT NULL
      );
    `);
    console.log('Tabela "nba_classificacao" verificada/criada com sucesso.');

    // Apaga os dados antigos na tabela para garantir que a tabela esteja limpa
    await client.query('TRUNCATE TABLE nba_classificacao;');
    console.log('Tabela "nba_classificacao" limpa.');

    // Reinicia a sequência do ID para 1
    await client.query('ALTER SEQUENCE nba_classificacao_id_seq RESTART WITH 1;');
    console.log('Sequência do ID reiniciada para 1.');

    console.log('Salvando novos dados no banco de dados...');
    for (const row of rows) {
      const { rank, teamName } = row;

      // Inserir novo registro no banco
      await client.query(
        `INSERT INTO nba_classificacao (rank, team_name) VALUES ($1, $2)`,
        [rank, teamName]
      );
      console.log(`Registro inserido no banco: Rank ${rank}, Time ${teamName}`);
    }
  } catch (error) {
    console.error('Erro ao salvar dados no banco de dados:', error);
  } finally {
    client.release();
  }
};

  // Salva os dados no banco de dados
  await saveDataToDatabase(rows);

  // Fecha o navegador
  await browser.close();
})();
