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
        console.log(`🔍 Buscando URL na tabela link Futebol: ${tableName}`);
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
        .replace(/[^a-z0-9]+/g, "_") + "rank";

    console.log(`📌 Nome da tabela extraído Link Futebol: ${formattedTableName}`);
    return { tableName: formattedTableName, url };
}


// ✅ Configuração do banco de dados (PostgreSQL)
const dbConfig = {
    connectionString: process.env.DATABASE_URL, // Usa a variável de ambiente
    ssl: { rejectUnauthorized: false }, // Evita erros de SSL no Render
};

async function scrapeAndSaveLinks(tableName, url) {
    url = url.replace('/lista/', '/classificacoes/');
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });
    const page = await browser.newPage();
    
    const client = new Client(dbConfig);
    await client.connect();

    await client.query(`
        CREATE TABLE IF NOT EXISTS "${tableName}" (
            id SERIAL PRIMARY KEY,
            rank INT,
            team_name VARCHAR(255) NOT NULL
        );
    `);
    await client.query(`TRUNCATE TABLE "${tableName}"`);
    console.log(`🗑️ Tabela ${tableName} limpa.`);

    try {
        console.log("📌 Acessando URL:", url);
        await page.goto(url, { timeout: 120000 });
        await sleep(10000);
        await page.waitForSelector('.ui-table__body');

        const rows = await page.$$eval('.ui-table__row', rows => {
            return rows.map(row => {
                const rankText = row.querySelector('.table__cell--rank .tableCellRank')?.innerText.trim();
                const rank = rankText ? parseInt(rankText.replace('.', ''), 10) : null;
                const teamElement = row.querySelector('.tableCellParticipant__name');
                const teamName = teamElement?.innerText.trim();
                
                return { rank, teamName };
            });
        });

        for (const { rank, teamName } of rows) {
            if (teamName) {
                await client.query(
                    `INSERT INTO "${tableName}" (rank, team_name) VALUES ($1, $2)`,
                    [rank, teamName]
                );
                console.log(`✅ Salvo: ${rank} - ${teamName}`);
            }
        }
    } catch (error) {
        console.error(`❌ Erro no scraping: ${error}`);
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
