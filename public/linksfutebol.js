const puppeteer = require('puppeteer');
const sleep = require('sleep-promise');
const { Client } = require('pg');
const fs = require('fs');

// ✅ Função para carregar a URL salva no backend
function getSavedUrl() {
    try {
        const url = fs.readFileSync('url.txt', 'utf8').trim();
        console.log("🔍 URL carregada no Puppeteer:", url);
        return url;
    } catch (error) {
        console.error("❌ Erro ao ler URL salva:", error);
        return 'https://www.flashscore.pt/basquetebol/eua/nba/lista/'; // URL padrão
    }
}

// ✅ URL dinâmica com fallback padrão
const url = getSavedUrl();

// ✅ Configuração do banco de dados (PostgreSQL)
const dbConfig = {
    connectionString: process.env.DATABASE_URL, // Usa a variável de ambiente
    ssl: { rejectUnauthorized: false }, // Evita erros de SSL no Render
};

async function scrapeAndSaveLinks() {
    // 🔹 Inicia o Puppeteer
    const browser = await puppeteer.launch({
        headless: true, // Modo invisível para otimizar o processamento
        args: ['--no-sandbox', '--disable-setuid-sandbox'], // Necessário para rodar no Render
    });
    const page = await browser.newPage();
    const page2 = await browser.newPage();

    // 🔹 Conexão com o banco de dados
    const client = new Client(dbConfig);
    await client.connect();

    // 🔹 Cria a tabela se não existir
    await client.query(`
        CREATE TABLE IF NOT EXISTS linksFutebol (
            id SERIAL PRIMARY KEY,
            team_name VARCHAR(255) NOT NULL,
            link VARCHAR(255) NOT NULL,
            event_time VARCHAR(50) NOT NULL
        );
    `);

    // 🔹 Limpa os links antigos antes de inserir os novos
    await client.query('TRUNCATE TABLE linksFutebol');
    console.log('🗑️ Tabela "linksFutebol" limpa.');

    try {
        console.log("📌 Acessando URL:", url);
        await page.goto(url, { timeout: 120000 });
        await sleep(10000);
        await page.waitForSelector('.container', { timeout: 90000 });

        // 🔹 Pega os IDs dos jogos
        const idObjects = await getNewIds(page, [], 20);

        for (const { id, eventTime } of idObjects) {
            const gameUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/sumario-do-jogo/`;
            console.log(`⚽ Processando: ${gameUrl}`);

            await page2.goto(gameUrl, { timeout: 120000 });
            await sleep(10000);

            const rows = await page2.$$('#detail > div.duelParticipant');

            for (const row of rows) {
                try {
                    const homeSelector = '#detail > div.duelParticipant > div.duelParticipant__home > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a';
                    const awaySelector = '#detail > div.duelParticipant > div.duelParticipant__away > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a';

                    const homeElement = await row.$(homeSelector);
                    const awayElement = await row.$(awaySelector);

                    const homeName = await page2.evaluate(el => el.innerText, homeElement);
                    const awayName = await page2.evaluate(el => el.innerText, awayElement);

                    const homeUrl = await page2.evaluate(el => el.href, homeElement);
                    const awayUrl = await page2.evaluate(el => el.href, awayElement);

                    // 🔹 Salvar no banco de dados
                    await client.query('INSERT INTO linksFutebol (team_name, link, event_time) VALUES ($1, $2, $3)', [homeName, homeUrl, eventTime]);
                    await client.query('INSERT INTO linksFutebol (team_name, link, event_time) VALUES ($1, $2, $3)', [awayName, awayUrl, eventTime]);

                    console.log(`✅ Salvo: ${homeName} | ${awayName}`);
                } catch (error) {
                    console.error(`❌ Erro ao processar linha: ${error}`);
                }
            }
        }
    } catch (error) {
        console.error(`❌ Erro geral no scraping: ${error}`);
    } finally {
        // 🔹 Fecha Puppeteer e a conexão com o banco
        await browser.close();
        await client.end();
    }
}

// ✅ Função para pegar IDs de jogos
async function getNewIds(page, excludedIds, neededCount) {
    return await page.evaluate((excludedIds, neededCount) => {
        const ids = [];
        document.querySelectorAll('[id]').forEach(el => {
            if (!excludedIds.includes(el.id)) {
                const timeElement = el.querySelector('.event__time');
                if (timeElement) {
                    ids.push({ id: el.id, eventTime: timeElement.textContent.trim() });
                }
            }
        });
        return ids.slice(0, neededCount);
    }, excludedIds, neededCount);
}

// 🔥 Inicia o processo
scrapeAndSaveLinks();
