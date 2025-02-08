require('dotenv').config();
const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');



// Configuração do pool de conexão ao banco de dados
const pool = new Pool({
 connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});

// Função para verificar se a tabela existe no banco de dados
const checkIfTableExists = async (teamTable) => {
    const client = await pool.connect();
    try {
        console.log(`🔍 Verificando se a tabela "${teamTable}" existe...`);
        const result = await client.query(
            `SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = $1
            )`, 
            [teamTable]
        );
        return result.rows[0].exists;
    } catch (error) {
        console.error(`❌ Erro ao verificar existência da tabela "${teamTable}":`, error);
        return false;
    } finally {
        client.release();
    }
};

// Função para obter a última data do banco de dados, criando a tabela se necessário
const getLastDateFromDatabase = async (teamTable) => {
    const client = await pool.connect();
    try {
        // Verifica se a tabela existe
        const tableExists = await checkIfTableExists(teamTable);
        if (!tableExists) {
            console.log(`⚠️ A tabela "${teamTable}" não existe. Criando agora...`);
            await createPlayersTable(teamTable); // Cria a tabela antes de buscar a última data
        }

        console.log(`📅 Buscando a última data na tabela "${teamTable}"...`);
        const result = await client.query(`SELECT datajogo FROM "${teamTable}" ORDER BY datajogo DESC LIMIT 1`);

        if (result.rows.length > 0) {
            console.log(`✅ Última data encontrada para a tabela "${teamTable}": ${result.rows[0].datajogo}`);
            return result.rows[0].datajogo;
        } else {
            console.log(`⚠️ Nenhuma data encontrada na tabela "${teamTable}"`);
            return null;
        }
    } catch (error) {
        console.error(`❌ Erro ao buscar a última data na tabela "${teamTable}":`, error);
        return null;
    } finally {
        client.release();
    }
};


// Função para verificar se a data já existe na tabela
const checkDateInDatabase = async (teamTable, specificDate) => {
    const client = await pool.connect();
    try {
        console.log(`Verificando se a data ${specificDate} já existe na tabela ${teamTable}...`);
        const result = await client.query(
            `SELECT COUNT(*) FROM "${teamTable}" WHERE datajogo = $1`, [specificDate]
        );

        const count = result.rows[0].count;
        if (count > 0) {
            console.log(`A data ${specificDate} já existe na tabela ${teamTable}.`);
            return true; // Retorna true se a data já existir
        } else {
            console.log(`A data ${specificDate} não foi encontrada na tabela ${teamTable}.`);
            return false; // Retorna false se a data não existir
        }
    } catch (error) {
        console.error(`Erro ao verificar a data na tabela ${teamTable}:`, error);
        return false;
    } finally {
        client.release();
    }
};


// Função para tentar navegar com tentativas de re-execução
const loadPageWithRetries = async (page, url, retries = 3) => {
    for (let attempt = 0; attempt < retries; attempt++) {
        try {
            console.log(`Tentativa ${attempt + 1} de carregar a página: ${url}`);
            await page.goto(url, { timeout: 120000, waitUntil: 'domcontentloaded' });
            console.log("Página carregada com sucesso.");
            return;
        } catch (error) {
            console.error(`Erro ao carregar a página na tentativa ${attempt + 1}:`, error.message);
            if (attempt === retries - 1) throw error; // Lançar o erro na última tentativa
        }
    }
};
// Função para criar uma tabela de estatísticas para um time
const createPlayersTable = async (teamName) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();
        console.log(`🔍 Verificando a criação da tabela "${tableName}" para o time: "${teamName}"...`);

        // Lista das estatísticas como colunas na tabela
        const estatisticas = [
    datajogo, timehome, resultadohome, playerName, resultadoaway,
    estatisticasJogo["golos esperados (xg)"] || 0,
    estatisticasJogo["posse de bola"] || 0,
    estatisticasJogo["tentativas de golo"] || 0,
    estatisticasJogo["remates à baliza"] || 0,
    estatisticasJogo["remates fora"] || 0,
    estatisticasJogo["remates bloqueados"] || 0,
    estatisticasJogo["grandes oportunidades"] || 0,
    estatisticasJogo["cantos"] || 0,
    estatisticasJogo["remates dentro da área"] || 0,
    estatisticasJogo["remates fora da área"] || 0,
    estatisticasJogo["acertou na trave"] || 0,
    estatisticasJogo["defesas de guarda-redes"] || 0,
    estatisticasJogo["livres"] || 0,
    estatisticasJogo["foras de jogo"] || 0,
    estatisticasJogo["faltas"] || 0,
    estatisticasJogo["cartões amarelos"] || 0,
    estatisticasJogo["lançamentos"] || 0,
    estatisticasJogo["toques na área adversária"] || 0,
    estatisticasJogo["passes"] || 0,
    estatisticasJogo["passes no último terço"] || 0,
    estatisticasJogo["cruzamentos"] || 0,
    estatisticasJogo["desarmes"] || 0,
    estatisticasJogo["intercepções"] || 0
];

        // Criar tabela com colunas de informações adicionais + estatísticas
        const query = `
    INSERT INTO "${tableName}" (
        datajogo, timehome, resultadohome, player_name, resultadoaway, 
        golos_esperados_xg, posse_de_bola, tentativas_de_golo, 
        remates_a_baliza, remates_fora, remates_bloqueados, 
        grandes_oportunidades, cantos, remates_dentro_da_area, 
        remates_fora_da_area, acertou_na_trave, defesas_de_guarda_redes, 
        livres, foras_de_jogo, faltas, cartoes_amarelos, 
        lancamentos, toques_na_area_adversaria, passes, 
        passes_no_ultimo_terco, cruzamentos, desarmes, intercepcoes
    ) VALUES (
        $1, $2, $3, $4, 
        $5, $6, $7, $8, 
        $9, $10, $11, $12, 
        $13, $14, $15, $16, 
        $17, $18, $19, $20, 
        $21, $22, $23, $24, 
        $25, $26, $27, $28
    )`;

        await client.query(query);
        console.log(`✅ Tabela "${tableName}" criada ou já existente para o time: "${teamName}".`);
    } catch (error) {
        console.error(`❌ Erro ao criar tabela para o time "${teamName}":`, error);
    } finally {
        client.release();
    }
};

// Função para corrigir a sequência do ID na tabela
const fixSequence = async (client, tableName) => {
    try {
        console.log(`🔄 Corrigindo a sequência da tabela "${tableName}"...`);
        const sequenceQuery = `
            SELECT setval(pg_get_serial_sequence('${tableName}', 'id'), (SELECT COALESCE(MAX(id), 1) FROM "${tableName}"))
        `;
        await client.query(sequenceQuery);
        console.log(`✅ Sequência da tabela "${tableName}" corrigida.`);
    } catch (error) {
        console.error(`❌ Erro ao corrigir a sequência da tabela "${tableName}":`, error);
        throw error;
    }
};

// Função para salvar os dados dos Time de Futebol no banco
const saveDataToPlayersTable = async (teamName, rowData) => {

    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();
        console.log(`💾 Salvando dados na tabela "${tableName}"...`);

        await fixSequence(client, tableName);

        for (const item of rowData) {
            const { rows: existingRows } = await client.query(
                `SELECT id FROM "${tableName}" WHERE player_name = $1 AND datajogo = $2`,
                [item.playerName, item.data_hora]
            );

            if (existingRows.length > 0) {
                console.log(`⚠️ Jogador ${item.playerName} já registrado nesta data. Pulando...`);
                continue;
            }

            // Inserção dinâmica das estatísticas
            const estatisticasKeys = [
                "golos_esperados_xg", "posse_de_bola", "tentativas_de_golo", "remates_a_baliza",
                "remates_fora", "remates_bloqueados", "grandes_oportunidades", "cantos",
                "remates_dentro_da_area", "remates_fora_da_area", "acertou_na_trave",
                "defesas_de_guarda_redes", "livres", "foras_de_jogo", "faltas",
                "cartoes_amarelos", "lancamentos", "toques_na_area_adversaria", "passes",
                "passes_no_ultimo_terco", "cruzamentos", "desarmes", "intercepcoes"
            ];

            const columns = ["datajogo", "timehome", "resultadohome", "player_name", "resultadoaway", ...estatisticasKeys];
            const values = [
                item.datajogo, item.timehome, item.resultadohome, item.playerName, item.resultadoaway,
                ...estatisticasKeys.map(stat => item[stat] || 0)
            ];

            const query = `
                INSERT INTO "${tableName}" (${columns.join(", ")})
                VALUES (${columns.map((_, i) => `$${i + 1}`).join(", ")})
            `;

            await client.query(query, values);

            console.log(`✅ Dados salvos para o jogador: ${item.playerName}`);
        }

        console.log(`✅ Todos os dados foram salvos para o time ${teamName}`);
    } catch (error) {
        console.error(`❌ Erro ao salvar dados na tabela "${teamName}":`, error);
    } finally {
        client.release();
    }
};





// Função para esperar o seletor com tentativas e lógica para pular em caso de falha
async function waitForSelectorWithRetries(page, selector, options, maxRetries = 3) {
    let retries = 0;
    while (retries < maxRetries) {
        try {
            await page.waitForSelector(selector, options);
            return; // Se o seletor for encontrado, sai da função
        } catch (error) {
            retries++;
            console.warn(`Tentativa ${retries}/${maxRetries} falhou ao esperar pelo seletor: ${selector}`);
            if (retries >= maxRetries) {
                console.error(`Falha ao esperar pelo seletor após ${maxRetries} tentativas: ${selector}`);
                throw error; // Lança o erro após o número máximo de tentativas
            }
            await sleep(2000); // Aguarda 2 segundos antes de tentar novamente
        }
    }
}


// Função para buscar links da tabela 'links'
const fetchLinksFromDatabase = async () => {
    const client = await pool.connect();
    try {
        console.log('Buscando todos os links da tabela "links Futebol"...');
        const result = await client.query('SELECT link FROM linksfutebol');
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
// Função para remover caracteres especiais e normalizar as strings
function normalizeString(str) {
    return str
        .toLowerCase()
        .normalize("NFD") // Decomposição de acentos
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace(/\([^)]*\)/g, '') // Remove tudo que estiver dentro de parênteses, incluindo os próprios parênteses
        .replace(/[\s\-]/g, ''); // Remove espaços e hífens
  }
  
// Scraping do site
const scrapeResults10 = async (link) => {
    const data = [];
    console.log(`🔍 Iniciando o scraping para o link: ${link}`);

    const fullLink = `${link}resultados/`;
    console.log('🔗 Link completo para scraping:', fullLink);

    const browser = await puppeteer.launch({
        headless: true, // Modo headless para execução eficiente
        args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições
    });

    const page = await browser.newPage();
    console.log('🌐 Abrindo navegador e acessando a página...', fullLink);
    await loadPageWithRetries(page, fullLink);

    const url = await page.evaluate(() => window.location.href);
    console.log('🔗 URL capturada:', url);

    // Extraindo o ID do time da URL
    const start_index = url.indexOf("/equipa/") + "/equipa/".length;
    const end_index = url.indexOf("/", start_index);
    const teamId = url.substring(start_index, end_index).replace(/-/g, ' ');
    let teamID10 = teamId.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase() + '_futebol';

    console.log(`🏆 ID do time processado: ${teamID10}`);

    await sleep(5000);
    await waitForSelectorWithRetries(page, '.container', { timeout: 90000 });

    // Obtendo IDs dos jogos
    const ids = await page.evaluate(() => {
        const sportName = document.querySelector('.sportName.soccer');
        if (!sportName) throw new Error('⚠️ SportName não encontrado');

        return [...sportName.querySelectorAll('[id]')].map(element => element.id).slice(0, 60);
    });

    const page2 = await browser.newPage();

    for (let id of ids) {
        const url = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/sumario-do-jogo/estatisticas-de-jogo/0`;
        console.log("📌 Processando URL:", url);
        await page2.goto(url, { timeout: 120000 });
        await sleep(5000);

        try {
            await page2.waitForSelector('div.duelParticipant__startTime', { timeout: 10000 });

            let timehome = await page2.$eval(`div.duelParticipant__home > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a`, 
                el => el.textContent.trim()).catch(() => null);

            let playerName = await page2.$eval(`div.duelParticipant__away > div.participant__participantNameWrapper`, 
                el => el.textContent.trim()).catch(() => null);

            let datajogo = await page2.$eval(`div.duelParticipant > div.duelParticipant__startTime`, 
                el => el.textContent.trim()).catch(() => '0000-00-00');

            let Resultadohome = await page2.$eval(`div.duelParticipant > div.duelParticipant__score > div > div.detailScore__wrapper > span:nth-child(1)`, 
                el => el.textContent.trim()).catch(() => '0');

            let Resultadoaway = await page2.$eval(`div.duelParticipant > div.duelParticipant__score > div > div.detailScore__wrapper > span:nth-child(3)`, 
                el => el.textContent.trim()).catch(() => '0');

            // Garantindo que os valores não sejam NULL
            if (!timehome) {
                console.warn("⚠️ timehome está vazio. Definindo como 'Desconhecido'.");
                timehome = 'Desconhecido';
            }

            if (!playerName) {
                console.warn("⚠️ playerName está vazio. Definindo como 'Desconhecido'.");
                playerName = 'Desconhecido';
            }

            console.log(`📊 Time Casa: ${timehome} | Time Visitante: ${playerName}`);
            console.log(`⚽ Placar: ${Resultadohome} x ${Resultadoaway}`);
            console.log(`📅 Data do Jogo: ${datajogo}`);

            let rowData = `${datajogo}, ${timehome}, ${playerName}, ${Resultadohome}, ${Resultadoaway}`;

            // Lista de estatísticas esperadas
            const estatisticasEsperadas = [
                "golos esperados (xg)", "posse de bola", "tentativas de golo", "remates à baliza",
                "remates fora", "remates bloqueados", "grandes oportunidades", "cantos",
                "remates dentro da área", "remates fora da área", "acertou na trave",
                "defesas de guarda-redes", "livres", "foras de jogo", "faltas",
                "cartões amarelos", "lançamentos", "toques na área adversária", "passes",
                "passes no último terço", "cruzamentos", "desarmes", "intercepções"
            ];

            let estatisticasJogo = {};
            estatisticasEsperadas.forEach(stat => {
                estatisticasJogo[stat] = '0';
            });

            // Extração das estatísticas do jogo
            try {
                const section = await page2.$('.section');
                if (!section) throw new Error('Elemento .section não encontrado.');

                const subsections = await section.$$('div[class*="row"]');
                if (subsections.length === 0) throw new Error('Nenhuma subseção encontrada.');

                console.log(`📌 Encontradas ${subsections.length} subseções.`);

                for (let i = 0; i < estatisticasEsperadas.length && i < subsections.length; i++) {
                    try {
                        const subsection = subsections[i];
                        let statisticName = await subsection.$eval(`div[class*="category"]`, el => el.textContent.trim()).catch(() => '');
                        let extractedValue = await subsection.$eval(`div[class*="homeValue"]`, el => el.textContent.trim()).catch(() => '0');

                        if (estatisticasEsperadas.includes(statisticName.toLowerCase())) {
                            estatisticasJogo[statisticName.toLowerCase()] = extractedValue;
                            console.log(`✅ Estatística: ${statisticName} -> ${extractedValue}`);
                        }
                    } catch (error) {
                        console.error(`❌ Erro ao extrair estatística da subseção ${i + 1}:`, error);
                    }
                }
            } catch (error) {
                console.error('❌ Erro ao extrair estatísticas:', error);
            }

            estatisticasEsperadas.forEach(stat => {
                rowData += `, ${estatisticasJogo[stat]}`;
            });

            console.log("🟢 Dados formatados:", rowData);

            // Salvando os dados no banco
            if (teamID10 && rowData.trim().length > 0) {
                await saveDataToPlayersTable(teamID10, rowData);
                console.log("🟢 Salvando dados no banco:",rowData);

                console.log(`✅ Dados salvos para o time ${teamID10}`);
            } else {
                console.warn("⚠️ Nenhum dado foi salvo. Verifique os valores extraídos.");
            }

        } catch (error) {
            console.error("❌ Erro ao processar o jogo:", error);
        }
    }

    console.log(`✅ Scraping finalizado para o link: ${link}`);
    await browser.close();
};

    // Função principal
    if (require.main === module) {
        (async () => {
            try {
                console.log("Executando script.js...");
    
                const links = await fetchLinksFromDatabase();
    
                // Log dos links no console
                console.log('Links obtidos do banco de dados:', linksfutebol);
    
                if (links.length === 0) {
                    console.log('Nenhum link encontrado para processamento.');
                    process.exit(0); // Nada a fazer, mas encerra com sucesso
                }
    
                for (const link of linksfutebol) {
                    console.log(`Iniciando o scraping para o link: ${link}`);
                    await scrapeResults(link);
                }
    
                console.log('Processo de scraping completo!');
                process.exit(0); // Indicar sucesso
            } catch (error) {
                console.error("Erro em script.js:", error);
                process.exit(1); // Indicar falha
            }
        })();
    }
    
    
    
    // script.js
    module.exports = { scrapeResults10 };
