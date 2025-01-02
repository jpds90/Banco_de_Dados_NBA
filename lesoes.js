require('dotenv').config();
const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');

// Configuração do pool de conexão ao banco de dados
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

// Função para criar a tabela de jogadores para o time
const createPlayersTable = async (teamName) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();

        console.log(`Verificando a criação da tabela "jogadores" para o time: "${teamName}"...`);

        await client.query(`
        DROP TABLE IF EXISTS "${tableName}_lesoes";
        `);
        await client.query(`
        CREATE TABLE IF NOT EXISTS "${tableName}_lesoes" (
            id SERIAL PRIMARY KEY,
            player_name VARCHAR(255) NOT NULL,
            injury_status VARCHAR(255),
            date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        `);
        console.log(`Tabela de lesões criada para o time: "${teamName}".`);
    } catch (error) {
        console.error(`Erro ao criar tabela de lesões para o time "${teamName}":`, error);
    } finally {
        client.release();
    }
};

    // Função para tentar navegar com tentativas de re-execução
    async function tryNavigate(url, page, maxRetries = 3) {
        for (let attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                await page.goto(url, { timeout: 120000 });
                return; // Se a navegação tiver sucesso, sai da função
            } catch (error) {
                if (error.name === 'TimeoutError' && attempt < maxRetries) {
                    console.log(`Timeout na tentativa ${attempt} para ${url}. Tentando novamente...`);
                } else {
                    console.error(`Erro ao navegar para ${url} após ${maxRetries} tentativas:`, error);
                    throw error; // Lança o erro se o número máximo de tentativas for atingido
                }
            }
        }
    }

// Função para salvar os dados das lesões no banco
const saveInjuriesToDatabase = async (teamName, players) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();
        console.log(`Salvando lesões dos jogadores na tabela "${tableName}_lesoes"...`);
        
        for (const playerName of players) {
            // Insere os jogadores lesionados
            await client.query(
                `INSERT INTO "${tableName}_lesoes" (player_name, injury_status) VALUES ($1, 'Lesionado')`,
                [playerName]
            );
            console.log(`Lesão salva para o jogador: ${playerName}`);
        }
    } catch (error) {
        console.error(`Erro ao salvar lesões na tabela "${tableName}_lesoes":`, error);
    } finally {
        client.release();
    }
};

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

// Scraping do site
const scrapeResults3 = async (link) => {
    const data = [];
    console.log(`Iniciando o scraping para o link: ${link}`);

    const fullLink = `${link}resultados/`;
    console.log('Link completo para scraping:', fullLink);

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    console.log('Abrindo o navegador e indo para a página...', fullLink);
    await page.goto(fullLink, { timeout: 120000 });

    const url = await page.evaluate(() => window.location.href);

    // Espera pela tabela de classificação carregar
    await sleep(5000);
    await page.waitForSelector('.lineupTable--basketball', { timeout: 90000 });

    // Extrai o texto dentro dos seletores
    const players = await page.evaluate(() => {
        const playerElements = Array.from(document.querySelectorAll('.lineupTable--basketball .lineupTable__cell--nameAndAbsence'));
        const uniquePlayers = new Set();
        playerElements.forEach(element => {
            if (element.querySelector('svg')) {
                const playerName = element.querySelector('a').textContent.trim();
                uniquePlayers.add(playerName);
            }
        });
        return Array.from(uniquePlayers);
    });

    // Exibe os resultados
    console.log(players);

    // Fecha o navegador
    await browser.close();

    // Extrai o nome do time do link
    const rawTeamName = link.split('/').slice(-3, -2)[0]; // Obtém o nome bruto do time
    const teamName = rawTeamName.replace('-', ' '); // Formata para exibição (ex.: "los angeles-lakers" -> "los angeles lakers")
    const normalizedTeamName = rawTeamName.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase(); // Normaliza para uso no banco (ex.: "los angeles-lakers" -> "los_angeles_lakers")

    console.log(`Time identificado a partir do link: ${teamName}`);

    // Cria a tabela de lesões e salva os dados no banco de dados
    await createPlayersTable(normalizedTeamName); // Cria a tabela para os jogadores
    await saveInjuriesToDatabase(normalizedTeamName, players); // Salva os dados das lesões dos jogadores

    console.log(`Scraping finalizado para o link: ${link}`);
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
            await scrapeResults3(link);
        }

        console.log('Processo de scraping completo!');
    })();
}

// Exporta a função de scraping
module.exports = { scrapeResults3 };
