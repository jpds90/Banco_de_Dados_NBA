const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração do banco de dados
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
});

// Função para salvar dados no banco
async function saveToDatabase(data) {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        await client.query('TRUNCATE TABLE odds RESTART IDENTITY');

        console.log('Tabela odds limpa e ID reiniciado.');

        const queryText = `
            INSERT INTO odds (data_jogo, time_home, time_away, home_odds, away_odds, over_dois_meio, over_odds, handicap)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
            RETURNING id
        `;

        for (const row of data) {
            await client.query(queryText, [
                row.dataJogo,
                row.timeHome,
                row.timeAway,
                row.homeOdds,
                row.awayOdds,
                row.overDoisMeioOdds,
                row.overOdds,
                row.handicappontos,
            ]);
        }

        await client.query('COMMIT');
        console.log('Dados salvos no banco com sucesso.');
    } catch (error) {
        await client.query('ROLLBACK');
        console.error('Erro ao salvar no banco de dados:', error);
    } finally {
        client.release();
    }
}

// Função principal de scraping
async function scrapeResults() {
    const browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-webgl',
            '--disable-features=IsolateOrigins,site-per-process',
        ],
    });

    const page = await browser.newPage();
    await page.setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36'
    );

    const page2 = await browser.newPage();
    await page2.setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36'
    );

    const futureGamesData = [];

    try {
        console.log("Acessando página principal...");
        await page.goto('https://www.flashscore.pt/basquetebol/eua/nba/lista/', { timeout: 300000, waitUntil: 'domcontentloaded' });
        await sleep(20000); // Espera 20 segundos para evitar bloqueios

        const ids = await page.evaluate(() => {
            const container = document.querySelector('.container');
            if (!container) throw new Error('Container não encontrado');
            const sportName = container.querySelector('.sportName.basketball');
            if (!sportName) throw new Error('sportName não encontrado');
            return [...sportName.querySelectorAll('[id]')].map(el => el.id).slice(0, 15);
        });

        for (let id of ids) {
            const summaryUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/`;
            console.log(`Processando: ${summaryUrl}`);

            try {
                await page2.goto(summaryUrl, { timeout: 300000, waitUntil: 'domcontentloaded' });
                await sleep(15000);

                let dataJogo, timeHome, timeAway;
                try {
                    dataJogo = await page2.$eval('.duelParticipant__startTime', el => el.textContent.trim());
                    const [datePart, time] = dataJogo.split(' ');
                    const [day, month] = datePart.split('.');
                    let year = new Date().getFullYear();
                    if (parseInt(month) < new Date().getMonth() + 1) year += 1;
                    const gameDateStr = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;

                    timeHome = await page2.$eval('.duelParticipant__home .participant__participantName a', el => el.textContent.trim());
                    timeAway = await page2.$eval('.duelParticipant__away .participant__participantName', el => el.textContent.trim());

                    console.log(`Jogo: ${timeHome} vs ${timeAway} em ${gameDateStr}`);
                } catch (error) {
                    console.error(`Erro ao extrair informações do jogo ${id}:`, error);
                    continue;
                }

                // Pegar odds 1x2
                const oddsUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds`;
                console.log("Processando odds 1x2:", oddsUrl);

                await page2.goto(oddsUrl, { timeout: 300000, waitUntil: 'domcontentloaded' });
                await sleep(15000);

                let homeOdds = '0', awayOdds = '0';
                try {
                    homeOdds = await page2.$eval('.oddsCell__odd:nth-child(2) span', el => el.textContent.trim());
                    awayOdds = await page2.$eval('.oddsCell__odd:nth-child(3) span', el => el.textContent.trim());
                    console.log(`Odds casa: ${homeOdds}, Odds visitante: ${awayOdds}`);
                } catch (error) {
                    console.error('Erro ao pegar odds 1x2:', error);
                }

                // Pegar Handicap
                const handicapUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/handicap-asiatico/tr-incluindo-prol`;
                console.log("Processando Handicap:", handicapUrl);

                await page2.goto(handicapUrl, { timeout: 300000, waitUntil: 'domcontentloaded' });
                await sleep(15000);

                let handicappontos = '0';
                try {
                    handicappontos = await page2.$eval('.oddsCell__noOddsCell', el => el.textContent.trim());
                    console.log(`Handicap: ${handicappontos}`);
                } catch (error) {
                    console.error('Erro ao pegar Handicap:', error);
                }

                // Pegar Over/Under
                const overUnderUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/mais-de-menos-de`;
                console.log("Processando Over/Under:", overUnderUrl);

                await page2.goto(overUnderUrl, { timeout: 300000, waitUntil: 'domcontentloaded' });
                await sleep(15000);

                let overDoisMeioOdds = '0', overOdds = '0';
                try {
                    overDoisMeioOdds = await page2.$eval('.oddsCell__odd:nth-child(2) span', el => el.textContent.trim());
                    overOdds = await page2.$eval('.oddsCell__noOddsCell', el => el.textContent.trim());
                    console.log(`Over 2.5: ${overDoisMeioOdds}, Over Odds: ${overOdds}`);
                } catch (error) {
                    console.error('Erro ao pegar Over/Under:', error);
                }

                futureGamesData.push({ dataJogo, timeHome, timeAway, homeOdds, awayOdds, overDoisMeioOdds, overOdds, handicappontos });
            } catch (error) {
                console.error('Erro no processamento do jogo:', error);
                continue;
            }
        }

        if (futureGamesData.length > 0) await saveToDatabase(futureGamesData);
    } catch (error) {
        console.error('Erro geral:', error);
    } finally {
        await browser.close();
    }
}

scrapeResults();
