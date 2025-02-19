const puppeteer = require('puppeteer');
const sleep = require('sleep-promise');
const { Client } = require('pg');
const fs = require('fs');
const { Pool } = require('pg');

// ✅ Conexão com o banco de dados
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
});

// ✅ Função para carregar a URL da liga salva no banco de dados
async function getSavedUrl(tableName) {
    const client = await pool.connect();
    try {
        console.log(`🔍 Buscando URL na tabela link Futebol: ${tableName}_link...`);
        const result = await client.query(`SELECT link FROM ${tableName} ORDER BY id DESC LIMIT 1`);

        if (result.rows.length > 0) {
            console.log(`✅ URL carregada do link Futebol ${tableName} : ${result.rows[0].link}`);
            return result.rows[0].link;
        } else {
            console.log("⚠️ Nenhuma URL encontrada. Usando URL padrão.");
            return 'https://www.flashscore.pt/futebol/'; // URL padrão
        }
    } catch (error) {
        console.error("❌ Erro ao buscar URL no banco:", error);
        return 'https://www.flashscore.pt/futebol/'; // URL padrão em caso de erro
    } finally {
        client.release();
    }
}

// ✅ Nome da tabela a partir da URL
async function getTableName(tableName) {
    if (!tableName) {
        console.error("❌ Nenhuma liga foi especificada!");
        return null;
    }

    const url = await getSavedUrl(tableName);
    const formattedTableName = tableName
        .toLowerCase()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
        .replace(/[^a-z0-9]+/g, "_") + "s";

    console.log(`📌 Nome da tabela extraído Link Futebol: ${formattedTableName}`);
    return { tableName: formattedTableName, url };
}



// ✅ Configuração do banco de dados (PostgreSQL)
const dbConfig = {
    connectionString: process.env.DATABASE_URL, // Usa a variável de ambiente
    ssl: { rejectUnauthorized: false }, // Evita erros de SSL no Render
};

async function scrapeAndSaveLinks(tableName, url) {
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
        CREATE TABLE IF NOT EXISTS "${tableName}" (
            id SERIAL PRIMARY KEY,
            team_name VARCHAR(255) NOT NULL,
            link VARCHAR(255) NOT NULL,
            event_time VARCHAR(50) NOT NULL
        );
    `);

    // 🔹 Limpa os links antigos antes de inserir os novos
    await client.query(`TRUNCATE TABLE "${tableName}"`);
    console.log(`🗑️ Tabela Links ${tableName} limpa.`);

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
            console.log("ID encontrado: ", el.id);  // Logar todos os IDs encontrados
            if (!excludedIds.includes(el.id)) {
                const timeElement = el.querySelector('.event__time');
                if (timeElement) {
                    ids.push({ id: el.id, eventTime: timeElement.textContent.trim() });
                }
            }
        });
        console.log("IDs extraídos: ", ids);  // Verifique os IDs extraídos
        return ids.slice(0, neededCount);
    }, excludedIds, neededCount);
}


// 🔥 Inicia o processo
async function startScraping() {
    const args = process.argv.slice(2);  // Pega argumentos da linha de comando
    const tableName = args[0];  // Primeiro argumento passado do backend

    if (!tableName) {
        console.error("❌ Nenhum tableName foi fornecido!");
        return;
    }

    const { tableName: formattedTable, url } = await getTableName(tableName);
    if (!formattedTable) return;

    scrapeAndSaveLinks(formattedTable, url);
}


startScraping();
module.exports = { scrapeAndSaveLinks };
