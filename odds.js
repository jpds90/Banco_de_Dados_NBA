const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração da conexão com o banco de dados
const pool = new Pool({
    connectionString: process.env.DATABASE_URL, // Usando a URL completa
    ssl: { rejectUnauthorized: false },
});

async function saveToDatabase(data) {
    const client = await pool.connect();
    try {
        await client.query('BEGIN');

        // Limpar tabela e reiniciar sequência de ID
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
                0, // home_odds
                0, // away_odds
                0, // over_dois_meio
                0, // over_odds
                0  // handicap
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
        headless: true, // Garante que o navegador rode em modo headless
        args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições no ambiente do Render
    });

    const page = await browser.newPage();
    const page2 = await browser.newPage();
    const futureGamesData = [];

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

        for (let id of ids) {
            const summaryUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/`;
            console.log("Processando URL de resumo:", summaryUrl);
            await page2.goto(summaryUrl, { timeout: 180000 });
            await sleep(10000);

            let gameDateStr = '';
            let timeHome = '';
            let timeAway = '';

            try {
                const dataJogo = await page2.$eval(
                    `div.duelParticipant__startTime`,
                    (element) => element.textContent.trim()
                );

                // Processa a data do jogo
                const [datePart, time] = dataJogo.split(' ');
                const [day, month] = datePart.split('.');
                let year = new Date().getFullYear();

                if (parseInt(month) < new Date().getMonth() + 1) {
                    year += 1;
                }

                gameDateStr = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;
                console.log(`Data do jogo ajustada: ${gameDateStr}`);

                // Processa os times
                timeHome = await page2.$eval(
                    `div.duelParticipant__home .participant__participantName a`,
                    (element) => element.textContent.trim()
                );

                timeAway = await page2.$eval(
                    `div.duelParticipant__away .participant__participantName`,
                    (element) => element.textContent.trim()
                );

                console.log(`Time da casa: ${timeHome}, Time visitante: ${timeAway}`);
            } catch (error) {
                console.error('Erro ao processar a página de resumo:', error);
                continue;
            }

            if (!gameDateStr) {
                console.error(`Data inválida para o jogo com ID ${id}. Ignorando entrada.`);
                continue;
            }

            futureGamesData.push({
                dataJogo: gameDateStr || 0,
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
