const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const fs = require('fs');
const sleep = require('sleep-promise');

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

// ✅ Extrair nome antes de "/lista/"
const tableName = url.split('/').slice(-3, -2)[0]
    .toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // Remove acentos
    .replace(/[^a-z0-9]+/g, "_") + "_odds"; // Substitui espaços e caracteres inválidos por "_"

console.log(`📌 Nome da tabela extraído: ${tableName}`);

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
});

async function createTableIfNotExists() {
    const client = await pool.connect();
    try {
        await client.query(`
            CREATE TABLE IF NOT EXISTS ${tableName} (
                id SERIAL PRIMARY KEY,
                data_jogo TIMESTAMP,
                time_home TEXT,
                time_away TEXT
            )
        `);
        console.log(`✅ Tabela ${tableName} verificada/criada com sucesso.`);
    } catch (error) {
        console.error(`❌ Erro ao criar tabela ${tableName}:`, error);
    } finally {
        client.release();
    }
}

async function saveToDatabase(data) {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        await client.query(`TRUNCATE TABLE ${tableName} RESTART IDENTITY`);
        console.log(`🧹 Tabela ${tableName} limpa.`);

        const queryText = `
            INSERT INTO ${tableName} (data_jogo, time_home, time_away)
            VALUES ($1, $2, $3)
        `;

        for (const row of data) {
            await client.query(queryText, [
                row.dataJogo,
                row.timeHome,
                row.timeAway
            ]);
        }

        await client.query('COMMIT');
        console.log('✅ Dados salvos no banco com sucesso.');
    } catch (error) {
        await client.query('ROLLBACK');
        console.error('❌ Erro ao salvar no banco de dados:', error);
    } finally {
        client.release();
    }
}

async function scrapeResults() {
    await createTableIfNotExists();

    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });

    const page = await browser.newPage();
    const page2 = await browser.newPage();
    const futureGamesData = [];

    try {
        await page.goto(url, { timeout: 180000 });
        await sleep(12000);

        const ids = await page.evaluate(() => {
            const container = document.querySelector('.container');
            if (!container) throw new Error('Container não encontrado');
            const sportName = container.querySelector('.sportName.soccer');
            if (!sportName) throw new Error('sportName não encontrado');
            const ids = [];
            sportName.querySelectorAll('[id]').forEach(element => ids.push(element.id));
            return ids.slice(0, 15);
        });

        for (let id of ids) {
            const summaryUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/`;
            console.log("Processando URL de resumo:", summaryUrl);
            await page2.goto(summaryUrl, { timeout: 180000 });
            await sleep(10000);

            let gameDateStr = '', timeHome = '', timeAway = '';

            try {
                const dataJogo = await page2.$eval(
                    'div.duelParticipant__startTime',
                    (element) => element.textContent.trim()
                );

                const [datePart, time] = dataJogo.split(' ');
                const [day, month] = datePart.split('.');
                let year = new Date().getFullYear();
                const currentMonth = new Date().getMonth() + 1;
                if (parseInt(month) < currentMonth) year += 1;
                gameDateStr = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;

                timeHome = await page2.$eval(
                    'div.duelParticipant__home .participant__participantName a',
                    (element) => element.textContent.trim()
                );
                timeAway = await page2.$eval(
                    'div.duelParticipant__away .participant__participantName',
                    (element) => element.textContent.trim()
                );
            } catch (error) {
                console.error('Erro ao processar a página de resumo:', error);
                continue;
            }

            if (!gameDateStr) continue;

            futureGamesData.push({
                dataJogo: gameDateStr,
                timeHome: timeHome || 'Indefinido',
                timeAway: timeAway || 'Indefinido'
            });
        }

        if (futureGamesData.length > 0) {
            await saveToDatabase(futureGamesData);
        }
    } catch (error) {
        console.error('Erro durante o scraping:', error);
    } finally {
        await browser.close();
    }
}

scrapeResults();
