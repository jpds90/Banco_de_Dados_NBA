const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração da conexão com o banco de dados
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: { rejectUnauthorized: false },
});

async function saveToDatabase(data) {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');
        await client.query('TRUNCATE TABLE odds RESTART IDENTITY');
        console.log('Tabela odds limpa e ID reiniciado.');

        const queryText = `
            INSERT INTO odds (data_jogo, time_home, time_away, home_odds, away_odds, over_dois_meio, over_odds)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            RETURNING id
        `;

        for (const row of data) {
            const { dataJogo, timeHome, timeAway, homeOdds, awayOdds, overDoisMeioOdds, overOdds } = row;
            await client.query(queryText, [
                dataJogo,
                timeHome,
                timeAway,
                homeOdds,
                awayOdds,
                overDoisMeioOdds,
                overOdds,
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

async function scrapeResults() {
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });
    const page = await browser.newPage();

    try {
        await page.goto('https://www.flashscore.pt/basquetebol/eua/nba/lista/', { timeout: 180000 });
        await sleep(12000);

        const ids = await page.evaluate(() => {
            const container = document.querySelector('.container');
            if (!container) throw new Error('Container não encontrado');
            const sportName = container.querySelector('.sportName.basketball');
            if (!sportName) throw new Error('sportName não encontrado');
            const ids = [];
            sportName.querySelectorAll('[id]').forEach(element => ids.push(element.id));
            return ids.slice(0, 15);
        });

        const page2 = await browser.newPage();
        const futureGamesData = [];

        for (let id of ids) {
            const summaryUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/`;
            console.log("Processando URL de resumo:", summaryUrl);
            await page2.goto(summaryUrl, { timeout: 180000 });
            await sleep(10000);

            let dataJogo = '';
            let timeHome = '';
            let timeAway = '';

            try {
                dataJogo = await page2.$eval(
                    `div.duelParticipant__startTime`,
                    (element) => element.textContent.trim()
                );
                timeHome = await page2.$eval(
                    `div.duelParticipant__home .participant__participantName a`,
                    (element) => element.textContent.trim()
                );
                timeAway = await page2.$eval(
                    `div.duelParticipant__away .participant__participantName`,
                    (element) => element.textContent.trim()
                );
            } catch (error) {
                console.error('Erro ao processar a página de resumo:', error);
                continue;
            }

            const oddsUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds`;
            console.log("Processando URL de odds 1x2:", oddsUrl);
            await page2.goto(oddsUrl, { timeout: 180000 });
            await sleep(10000);

            let homeOdds = '';
            let awayOdds = '';

            try {
                const homeOddsElement = await page2.$('#detail > div:nth-child(7) > div > div.oddsTab__tableWrapper > div > div.ui-table__body > div > a:nth-child(2) > span');
                const awayOddsElement = await page2.$('#detail > div:nth-child(7) > div > div.oddsTab__tableWrapper > div > div.ui-table__body > div > a:nth-child(3) > span');
                
                if (homeOddsElement && awayOddsElement) {
                    homeOdds = await homeOddsElement.evaluate((element) => element.textContent.trim());
                    awayOdds = await awayOddsElement.evaluate((element) => element.textContent.trim());
                } else {
                    console.log('Elementos de odds não encontrados.');
                    continue;
                }
            } catch (error) {
                console.error('Erro ao processar a página de odds 1x2:', error);
                continue;
            }

            const oddsmaisemenosUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/mais-de-menos-de`;
            console.log("Processando URL Pontos:", oddsmaisemenosUrl);
            await page2.goto(oddsmaisemenosUrl, { timeout: 180000 });
            await sleep(10000);

            let overDoisMeioOdds = '';
            let overOdds = '';

            try {
                const oddsTableWrapper = await page2.$('.oddsTab__tableWrapper');
                const oddsTables = await oddsTableWrapper.$$('.ui-table.oddsCell__odds');
                if (oddsTables.length > 0) {
                    const targetTable = oddsTables[0];
                    const maisdoismeioRows = await targetTable.$$('.ui-table__body .ui-table__row');
                    if (maisdoismeioRows.length > 0) {
                        const maisdoismeioRow = maisdoismeioRows[0];
                        const oddsCells = await maisdoismeioRow.$$('.oddsCell__odd');
                        if (oddsCells.length > 0) {
                            overDoisMeioOdds = await oddsCells[0].evaluate((element) => element.textContent.trim());
                            overOdds = await oddsCells[0].evaluate(element => element.textContent.trim());
                        }
                    }
                }
            } catch (error) {
                console.error('Erro ao processar a página de odds mais de/menos de:', error);
                continue;
            }

            futureGamesData.push({
                dataJogo: dataJogo || 'Indefinido',
                timeHome: timeHome || 'Indefinido',
                timeAway: timeAway || 'Indefinido',
                homeOdds: isNaN(homeOdds) ? 0 : parseFloat(homeOdds),
                awayOdds: isNaN(awayOdds) ? 0 : parseFloat(awayOdds),
                overDoisMeioOdds: isNaN(overDoisMeioOdds) ? 0 : parseFloat(overDoisMeioOdds),
                overOdds: isNaN(overOdds) ? 0 : parseFloat(overOdds),
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
