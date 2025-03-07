const puppeteer = require('puppeteer');
const sleep = require('sleep-promise');
const { Client } = require('pg');

// Configuração do banco de dados
const dbConfig = {
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
};

async function scrapeAndSaveLinks() {
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
  });
  const page = await browser.newPage();
  const page2 = await browser.newPage();
  const client = new Client(dbConfig);
  await client.connect();

  // Criar tabela se não existir
  await client.query(`
    CREATE TABLE IF NOT EXISTS links (
      id SERIAL PRIMARY KEY,
      team_name VARCHAR(255) NOT NULL,
      link VARCHAR(255) NOT NULL,
      event_time VARCHAR(50) NOT NULL
    );
  `);

  // Limpar a tabela de links antes de adicionar novos dados
  await client.query('TRUNCATE TABLE links');
  console.log('Tabela "links" limpa com sucesso.');

  try {
    await page.goto('https://www.flashscore.pt/basquetebol/eua/nba/lista/', { timeout: 120000 });
    await sleep(10000);
    await page.waitForSelector('.container', { timeout: 90000 });

    const idObjects = await getNewIds(page, [], 20);

    for (const { id, eventTime } of idObjects) {
      const url = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/sumario-do-jogo/`;
      console.log(`Processando: ${url}`);

      await page2.goto(url, { timeout: 120000 });
      await sleep(10000);

      const homeNameElement = await page2.$(
        '#detail > div.duelParticipant > div.duelParticipant__home > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a'
      );
      const awayNameElement = await page2.$(
        '#detail > div.duelParticipant > div.duelParticipant__away > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a'
      );

      if (!homeNameElement || !awayNameElement) {
        console.warn(`Elementos não encontrados para o jogo ${id}`);
        continue;
      }

      const homeName = await page2.evaluate(el => el.innerText, homeNameElement);
      const awayName = await page2.evaluate(el => el.innerText, awayNameElement);

      const homeUrl = await page2.evaluate(el => el.href, homeNameElement);
      const awayUrl = await page2.evaluate(el => el.href, awayNameElement);

      // Salvar no banco de dados
      await client.query(
        'INSERT INTO links (team_name, link, event_time) VALUES ($1, $2, $3)',
        [homeName, homeUrl, eventTime]
      );
      await client.query(
        'INSERT INTO links (team_name, link, event_time) VALUES ($1, $2, $3)',
        [awayName, awayUrl, eventTime]
      );

      console.log(`Salvo: ${homeName}, ${awayName}`);
    }
  } catch (error) {
    console.error(`Erro geral: ${error}`);
  } finally {
    await browser.close();
    await client.end();
  }
}

async function getNewIds(page, excludedIds, neededCount) {
  return await page.evaluate((excludedIds, neededCount) => {
    return Array.from(document.querySelectorAll('[id]'))
      .filter(el => !excludedIds.includes(el.id) && el.querySelector('.event__time'))
      .slice(0, neededCount)
      .map(el => ({ id: el.id, eventTime: el.querySelector('.event__time').textContent.trim() }));
  }, excludedIds, neededCount);
}

scrapeAndSaveLinks();

