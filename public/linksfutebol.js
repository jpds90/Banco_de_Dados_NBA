const puppeteer = require('puppeteer');
const sleep = require('sleep-promise');
const { Client } = require('pg');
const fs = require('fs');


// ✅ Função para carregar a URL salva no backend
async function getTableName() {
    const url = await getSavedUrl(tableName);


// ✅ Extrair nome antes de "/lista/"
const tableName = url
    .split('/')
    .slice(-3, -2)[0] // Pega o nome correto na URL
    .toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // Remove acentos
    .replace(/[^a-z0-9]+/g, "_") // Substitui espaços e caracteres inválidos por "_"
    .replace(/^_+|_+$/g, "") + "_link1"; // Remove "_" extras e adiciona "_link"

console.log(tableName); // Exemplo: "serie_a_link"


// ✅ Configuração do banco de dados (PostgreSQL)
const dbConfig = {
    connectionString: process.env.DATABASE_URL, // Usa a variável de ambiente
    ssl: { rejectUnauthorized: false }, // Evita erros de SSL no Render
};

async function scrapeAndSaveLinks(tableName) {
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });
    const page = await browser.newPage();
    const page2 = await browser.newPage();

    const client = new Client(dbConfig);
    await client.connect();

    await client.query(`
        CREATE TABLE IF NOT EXISTS "${tableName}" (
            id SERIAL PRIMARY KEY,
            team_name VARCHAR(255) NOT NULL,
            link VARCHAR(255) NOT NULL,
            event_time VARCHAR(50) NOT NULL
        );
    `);

    await client.query(`TRUNCATE TABLE "${tableName}"`);
    console.log(`🗑️ Tabela ${tableName} limpa.`);
    
    try {
        console.log("📌 Acessando URL:", url);
        await page.goto(url, { timeout: 120000 });
        await sleep(10000);
        await page.waitForSelector('.container', { timeout: 90000 });

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

                    await client.query(`INSERT INTO "${tableName}" (team_name, link, event_time) VALUES ($1, $2, $3)`, [homeName, homeUrl, eventTime]);
                    await client.query(`INSERT INTO "${tableName}" (team_name, link, event_time) VALUES ($1, $2, $3)`, [awayName, awayUrl, eventTime]);

                    console.log(`✅ Salvo: ${homeName} | ${awayName}`);
                } catch (error) {
                    console.error(`❌ Erro ao processar linha: ${error}`);
                }
            }
        }
    } catch (error) {
        console.error(`❌ Erro geral no scraping: ${error}`);
    } finally {
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
module.exports = { scrapeAndSaveLinks };

