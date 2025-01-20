require('dotenv').config();
const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração do pool de conexão ao banco de dados
const pool = new Pool({ connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});

// Função para buscar links da tabela 'links'
const fetchLinksFromDatabase = async () => {
    const client = await pool.connect();
    try {
        console.log('Buscando todos os links da tabela "links"...');
        const result = await client.query('SELECT link FROM links');
        if (result.rows.length > 0) {
            console.log(`${result.rows.length} links encontrados no banco de dados.`);
            return result.rows.map(row => row.link);
        } else {
            console.log('Nenhum link encontrado na tabela "links".');
            return [];
        }
    } catch (error) {
        console.error('Erro ao buscar links no banco de dados:', error);
        return [];
    } finally {
        client.release();
    }
};

// Função para criar tabela para o time do link (se ainda não existir)
const createTeamTableForLink = async (teamName) => {
    const client = await pool.connect();
    try {
        // Normaliza o nome da tabela substituindo caracteres inválidos por "_"
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase(); 
        console.log(`Verificando existência da tabela para o time "${teamName}"...`);
        await client.query(`
            CREATE TABLE IF NOT EXISTS ${tableName} (
                id SERIAL PRIMARY KEY,
                datahora VARCHAR(50) NOT NULL,
                home_team VARCHAR(255) NOT NULL,
                home_score VARCHAR(10),
                away_team VARCHAR(255) NOT NULL,
                away_score VARCHAR(10),
                home_team_q1 VARCHAR(10),
                home_team_q2 VARCHAR(10),
                home_team_q3 VARCHAR(10),
                home_team_q4 VARCHAR(10),
                away_team_q1 VARCHAR(10),
                away_team_q2 VARCHAR(10),
                away_team_q3 VARCHAR(10),
                away_team_q4 VARCHAR(10)
            );
        `);
        console.log(`Tabela "${tableName}" criada/verificada.`);
    } catch (error) {
        console.error(`Erro ao criar/verificar tabela para o time "${teamName}":`, error);
    } finally {
        client.release();
    }
};



// Função para salvar dados na tabela do time
const saveDataToTeamTable = async (teamName, data) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/\s+/g, '_').toLowerCase();
        console.log(`Salvando dados na tabela "${tableName}"...`);
        
        // Inverte a ordem dos dados para salvar o primeiro extraído no fim e o último no topo
        const reversedData = [...data].reverse();

        for (const item of reversedData) {
            // Verifica se já existe um registro com a mesma data e time
            const result = await client.query(
                `SELECT COUNT(*) AS count FROM ${tableName} WHERE datahora = $1 AND home_team = $2`,
                [item.DataHora, item.homeTeam]
            );
            const exists = parseInt(result.rows[0].count, 10) > 0;

            if (!exists) {
                await client.query(
                    `INSERT INTO ${tableName} (
                        datahora, home_team, home_score, away_team, away_score,
                        home_team_q1, home_team_q2, home_team_q3, home_team_q4,
                        away_team_q1, away_team_q2, away_team_q3, away_team_q4
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
                    [
                        item.DataHora, item.homeTeam, item.homeScore, item.awayTeam, item.awayScore,
                        item.homeTeamQuarter1Score, item.homeTeamQuarter2Score, item.homeTeamQuarter3Score, item.homeTeamQuarter4Score,
                        item.awayTeamQuarter1Score, item.awayTeamQuarter2Score, item.awayTeamQuarter3Score, item.awayTeamQuarter4Score,
                    ]
                );
                console.log(`Registro salvo na tabela "${tableName}":`, item);
            } else {
                console.log(
                    `Registro já existente na tabela "${tableName}" para data "${item.DataHora}" e time "${item.homeTeam}". Ignorando.`
                );
            }
        }
    } catch (error) {
        console.error(`Erro ao salvar dados na tabela "${teamName}":`, error);
    } finally {
        client.release();
    }
};


// Scraping do site
const scrapeResults = async (link) => {
    console.log(`Iniciando o scraping para o link: ${link}`);

    const fullLink = `${link}resultados/`;
    console.log('Link completo para scraping:', fullLink);

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    console.log('Abrindo o navegador e indo para a página...', fullLink);
    await page.goto(fullLink, { timeout: 120000 });

    // Função para clicar no botão "Mostrar mais jogos"
    const clickMoreGamesButton = async (page) => {
        const buttonSelector = 'span[data-testid="wcl-scores-caption-03"]';
        const maxClicks = 4;

        for (let i = 0; i < maxClicks; i++) {
            try {
                await page.waitForSelector(buttonSelector, { visible: true, timeout: 5000 });
                await page.evaluate(selector => {
                    const button = document.querySelector(selector);
                    if (button && button.innerText === "Mostrar mais jogos") {
                        button.click();
                    }
                }, buttonSelector);
                console.log(`Botão "Mostrar mais jogos" clicado ${i + 1} vez(es)`);
                await sleep(2000);
            } catch (error) {
                console.error('O botão "Mostrar mais jogos" não foi encontrado ou não estava visível a tempo:', error);
                break;
            }
        }
    };

    await sleep(5000);
    // Clica no botão "Mostrar mais jogos"
    await clickMoreGamesButton(page);

    await page.waitForSelector('.sportName.basketball', { timeout: 90000 });

    const data = await page.evaluate(() => {
        const results = [];
        const sportName = document.querySelector('.sportName.basketball');
        sportName.querySelectorAll('[id]').forEach(element => {
            const DataHora = element.querySelector('.event__time')?.innerText;
            const homeTeam = element.querySelector('.event__participant.event__participant--home')?.innerText;
            const awayTeam = element.querySelector('.event__participant.event__participant--away')?.innerText;
            const homeScore = element.querySelector('.event__score.event__score--home')?.innerText;
            const awayScore = element.querySelector('.event__score.event__score--away')?.innerText;
            const homeTeamQuarter1Score = element.querySelector('.event__part.event__part--home.event__part--1')?.innerText;
            const awayTeamQuarter1Score = element.querySelector('.event__part.event__part--away.event__part--1')?.innerText;
            const homeTeamQuarter2Score = element.querySelector('.event__part.event__part--home.event__part--2')?.innerText;
            const awayTeamQuarter2Score = element.querySelector('.event__part.event__part--away.event__part--2')?.innerText;
            const homeTeamQuarter3Score = element.querySelector('.event__part.event__part--home.event__part--3')?.innerText;
            const awayTeamQuarter3Score = element.querySelector('.event__part.event__part--away.event__part--3')?.innerText;
            const homeTeamQuarter4Score = element.querySelector('.event__part.event__part--home.event__part--4')?.innerText;
            const awayTeamQuarter4Score = element.querySelector('.event__part.event__part--away.event__part--4')?.innerText;

            results.push({
                DataHora, homeTeam, homeScore, awayTeam, awayScore, homeTeamQuarter1Score, awayTeamQuarter1Score, homeTeamQuarter2Score, awayTeamQuarter2Score, homeTeamQuarter3Score, awayTeamQuarter3Score,
                homeTeamQuarter4Score, awayTeamQuarter4Score,
            });
        });
        return results;
    });

// Extrai o nome do time do link
const rawTeamName = link.split('/').slice(-3, -2)[0]; // Obtém o nome bruto do time
const teamName = rawTeamName.replace('-', ' '); // Formata para exibição (ex.: "los angeles-lakers" -> "los angeles lakers")
const normalizedTeamName = rawTeamName.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase(); // Normaliza para uso no banco (ex.: "los angeles-lakers" -> "los_angeles_lakers")

console.log(`Time identificado a partir do link: ${teamName}`);

// Cria a tabela apenas para o time do link
await createTeamTableForLink(normalizedTeamName);

// Salva todos os dados na tabela do time
await saveDataToTeamTable(normalizedTeamName, data);

console.log(`Finalizado o scraping para o link: ${fullLink}`);
await browser.close();

};


// Função principal
if (require.main === module) {
    (async () => {
        const links = await fetchLinksFromDatabase();

        // Log dos links no console
        console.log('Links obtidos do banco de dados:', links);

        if (links.length === 0) {
            console.log('Nenhum link encontrado para processamento.');
            return;
        }

        for (const link of links) {
            console.log(`Iniciando o scraping para o link: ${link}`);
            await scrapeResults(link);
        }

        console.log('Processo de scraping completo!');
    })();
}


// script.js
module.exports = { scrapeResults };
