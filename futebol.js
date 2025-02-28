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
        const result = await client.query(`SELECT data_hora FROM "${teamTable}" ORDER BY data_hora DESC LIMIT 1`);

        if (result.rows.length > 0) {
            console.log(`✅ Última data encontrada para a tabela "${teamTable}": ${result.rows[0].data_hora}`);
            return result.rows[0].data_hora;
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
            `SELECT COUNT(*) FROM "${teamTable}" WHERE data_hora = $1`, [specificDate]
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
// Função para salvar os dados no banco
const createPlayersTable = async (teamName) => {
    const client = await pool.connect();
    try {
        const tableName = teamName
    .normalize("NFD")                  // Normaliza para decompor caracteres acentuados
    .replace(/[\u0300-\u036f]/g, "")   // Remove os acentos
    .replace(/[^a-zA-Z0-9/]/g, "_")    // Substitui todos os caracteres não alfanuméricos (exceto "/") por "_"
    .toLowerCase();


        console.log(`Verificando a criação da tabela "jogadores" para o time: "${teamName}"...`);

        // Remove o DROP TABLE e mantém a verificação apenas para criar caso não exista
        await client.query(`
            CREATE TABLE IF NOT EXISTS "${tableName}" (
                id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                data_hora VARCHAR(50) NOT NULL,
                timehome VARCHAR(255) NOT NULL,
                resultadohome INT,
                timeaway VARCHAR(255) NOT NULL,
                resultadoaway INT,
                golos_esperados_xg INT,
                posse_de_bola INT,
                tentativas_de_golo INT,
                remates_a_baliza INT,
                remates_fora INT,
                remates_bloqueados INT,
                grandes_oportunidades INT,
                cantos INT,
                remates_dentro_da_area INT,
                remates_fora_da_area INT,
                acertou_na_trave INT,
                defesas_de_guarda_redes INT,
                livres INT,
                foras_de_jogo INT,
                faltas INT,
                cartoes_amarelos INT,
                lancamentos INT,
                toques_na_area_adversaria INT,
                passes INT,
                passes_no_ultimo_terco INT,
                cruzamentos INT,
                desarmes INT,
                intercepcoes INT
            )
        `);
        console.log(`Tabela "jogadores" criada ou já existente para o time: "${teamName}".`);
    } catch (error) {
        console.error(`Erro ao criar tabela para o time "${teamName}":`, error);
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

const cleanNumber = (value) => {
    if (typeof value === "string") {
        return value.split(" ")[0].replace("%", "").trim() || '0'; // Pega só o primeiro número e remove "%"
    }
    return value || '0';
};


const saveDataToPlayersTable = async (teamName, data) => {
    const client = await pool.connect();
    try {
        const tableName = teamName
    .normalize("NFD")                  // Normaliza para decompor caracteres acentuados
    .replace(/[\u0300-\u036f]/g, "")   // Remove os acentos
    .replace(/[^a-zA-Z0-9/]/g, "_")    // Substitui todos os caracteres não alfanuméricos (exceto "/") por "_"
    .toLowerCase();

        console.log(`🔵 Salvando dados na tabela "${tableName}"...`);

        // Corrigir a sequência antes de salvar os dados
        await fixSequence(client, tableName);

        // Verificar se o jogo já está registrado
        const { rows: existingRows } = await client.query(
            `SELECT id FROM "${tableName}" WHERE timehome = $1 AND timeaway = $2 AND data_hora = $3`,
            [data.timehome, data.timeaway, data.data_hora]
        );

        if (existingRows.length > 0) {
            console.log(`⚠️ Jogo entre ${data.timehome} e ${data.timeaway} em ${data.data_hora} já registrado. Pulando...`);
            return;
        }

        // Inserir os dados do jogo
await client.query(
    `INSERT INTO "${tableName}" (
        data_hora, timehome, resultadohome, timeaway, resultadoaway,
        golos_esperados_xg, posse_de_bola, tentativas_de_golo, remates_a_baliza,
        remates_fora, remates_bloqueados, grandes_oportunidades, cantos,
        remates_dentro_da_area, remates_fora_da_area, acertou_na_trave,
        defesas_de_guarda_redes, livres, foras_de_jogo, faltas,
        cartoes_amarelos, lancamentos, toques_na_area_adversaria, passes,
        passes_no_ultimo_terco, cruzamentos, desarmes, intercepcoes
    ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28
    )`,
    [
        data.data_hora || "1900-01-01 00:00:00",  data.timehome || "Desconhecido", data.resultadohome || 0, data.timeaway || "Desconhecido", data.resultadoaway || 0,
        cleanNumber(data.golos_esperados_xg), cleanNumber(data.posse_de_bola),
        cleanNumber(data.tentativas_de_golo), cleanNumber(data.remates_a_baliza),
        cleanNumber(data.remates_fora), cleanNumber(data.remates_bloqueados),
        cleanNumber(data.grandes_oportunidades), cleanNumber(data.cantos),
        cleanNumber(data.remates_dentro_da_area), cleanNumber(data.remates_fora_da_area),
        cleanNumber(data.acertou_na_trave), cleanNumber(data.defesas_de_guarda_redes),
        cleanNumber(data.livres), cleanNumber(data.foras_de_jogo),
        cleanNumber(data.faltas), cleanNumber(data.cartoes_amarelos),
        cleanNumber(data.lancamentos), cleanNumber(data.toques_na_area_adversaria),
        cleanNumber(data.passes), cleanNumber(data.passes_no_ultimo_terco),
        cleanNumber(data.cruzamentos), cleanNumber(data.desarmes),
        cleanNumber(data.intercepcoes)
    ]
);


        console.log(`✅ Dados salvos para ${data.timehome} vs ${data.timeaway} (${data.data_hora})`);
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
            await sleep(6000); // Aguarda 2 segundos antes de tentar novamente
        }
    }
}

const fetchLinksFromDatabase1 = async (tableName) => {
  const client = await pool.connect();
  const modifiedTableName = `${tableName}s`; // Adiciona o "s" ao nome da tabela

  try {
    console.log(`🔍 Buscando dados na tabela: ${modifiedTableName}...`);

    // Verifica se a tabela realmente existe no banco de dados
    const checkTable = await client.query(
      `SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = $1) AS exists`,
      [modifiedTableName]
    );

    if (!checkTable.rows[0].exists) {
      console.error(`❌ Erro: A tabela ${modifiedTableName} não existe no banco de dados.`);
      return;
    }

    // Busca os registros na tabela, agora incluindo team_name e link
    const result = await client.query(`SELECT team_name, link FROM ${modifiedTableName}`);
    if (result.rows.length > 0) {
      console.log(`✅ ${result.rows.length} registros encontrados.`);
      // Itera e chama o scraping para cada registro, enviando team_name e link
      for (const registro of result.rows) {
        console.log("🔄 Chamando scrapeResults10 para:", registro.link, "com team_name:", registro.team_name);
        await scrapeResults10(registro.link, registro.team_name);
      }
    } else {
      console.log("⚠️ Nenhum registro encontrado.");
    }
  } catch (error) {
    console.error(`❌ Erro ao buscar ou processar os dados na tabela ${modifiedTableName}:`, error);
  } finally {
    client.release();
  }
};


// Função para remover "Segue em frente" e conteúdo dentro de parênteses
function normalizeString(str) {
    if (!str) return '';  // Garantir que a string não seja nula ou vazia
    return str
        .toLowerCase()
        .normalize("NFD") // Decomposição de acentos
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace(/\([^)]*\)/g, '') // Remove tudo que estiver dentro de parênteses, incluindo os próprios parênteses
        .replace(/[\s\-]/g, '') // Remove espaços e hífens
        .replace(/\./g, '')  // Remove todos os pontos na string
        .replace(/(\([^()]*\)|Segue em frente)/g, '') // Remove parênteses e "Segue em frente"
        .trim(); // Remove espaços extras no início e no fim
}

// Função para remover "Segue em frente" e conteúdo dentro de parênteses
function normalizecoluna(str) {
    if (!str) return ''; // Evita erros se a string for undefined ou null

    return str
        .normalize("NFD") // Decomposição de acentos
        .replace(/\([^)]*\)/g, '') // Remove tudo que estiver dentro de parênteses
        .replace(/(\([^()]*\)|Segue em frente)/g, '') // Remove parênteses e "Segue em frente"
        .replace(/\s+/g, ' ') // Substitui múltiplos espaços por um único espaço
        .trim(); // Remove espaços extras no início e no fim
}




// Função de scraping
// Função de scraping modificada para receber team_name
const scrapeResults10 = async (link, team_name) => {
    console.log(`Iniciando o scraping para o link: ${link}`);
    console.log(`Team name recebido: ${team_name}`);

    const fullLink = `${link}resultados/`;
    console.log('Link completo para scraping:', fullLink);

    const browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-accelerated-2d-canvas',
            '--no-zygote',
            '--single-process',
        ],
    });

    const page = await browser.newPage();
    console.log('Abrindo o navegador e indo para a página...', fullLink);
    await loadPageWithRetries(page, fullLink);

    const url = await page.evaluate(() => window.location.href);
    console.log('URL capturada:', url);

    let teamID10 = null;
    if (team_name && typeof team_name === 'string') {
        // Exemplo: transforma "Girona" em "girona_futebol"
         teamID10 = team_name
    .replace(/\./g, '') // Remove pontos
    .replace(/\s*\(\s*/g, '_') // Substitui " (" ou "( " por "_"
    .replace(/\s*\)/g, '') // Remove ") " ou " )"
    .replace(/\s+/g, '_') // Substitui espaços extras por um único "_"
    .toLowerCase() + '_futebol';

        console.log(`ID do time processado (via team_name): ${teamID10}`);
    } else {
        console.log('Erro: team_name não foi fornecido ou não é válido.');
    }
    if (team_name && typeof team_name === 'string') {
        // Exemplo: transforma "Girona" em "giron"
        teamId = team_name.replace(/\./g, '').toLowerCase();
        console.log(`ID do time processado: ${teamId}`);
    } else {
        console.log('Erro: team_name não foi fornecido ou não é válido.');
    }
    await sleep(10000);
    await waitForSelectorWithRetries(page, '.container', { timeout: 120000 });

    const ids = await page.evaluate(() => {
        const sportName = document.querySelector('.sportName.soccer');
        if (!sportName) throw new Error('SportName não encontrado');
        return [...sportName.querySelectorAll('[id]')].map(element => element.id).slice(0, 60);
    });

    console.log(ids);

    const page2 = await browser.newPage();
    let teamData = '';

    for (let id of ids) {
        const url = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/sumario-do-jogo/estatisticas-de-jogo/0`;
        console.log("Processando URL:", url);
        await page2.goto(url, { timeout: 120000 });

        await sleep(10000);

        if (teamID10) {
            const lastDate = await getLastDateFromDatabase(teamID10);
            console.log(`Última data encontrada para a tabela ${teamID10}: ${lastDate}`);

            try {
                await page2.waitForSelector('div.duelParticipant__startTime', { timeout: 10000 });

                const statisticElementHandle = await page2.$('div.duelParticipant__startTime');

                if (statisticElementHandle) {
                    const statisticData = await page2.evaluate(el => el.textContent.trim(), statisticElementHandle);
                    console.log(`Data ${statisticData} encontrada!`);

                    const dateExists = await checkDateInDatabase(teamID10, statisticData);

                    if (dateExists) {
                        console.log(`A data ${statisticData} já foi registrada. Pulando para o próximo jogador.`);
                        break;  // 🔹 Sai do loop imediatamente
                    } else {
                        console.log(`A data ${statisticData} ainda não foi registrada. Continuando processamento...`);
                    }
                } else {
                    console.log("❌ Elemento de data do jogo não encontrado!");
                }
            } catch (error) {
                console.error("Erro ao extrair a data do jogo:", error);
            }
        }

        try {
            const rows = await page2.$$(`#detail`);
            for (const row of rows) {
                let rowData = '';

                // Extração da data do jogo
                let data_hora = await row.$eval(`div.duelParticipant > div.duelParticipant__startTime`, el => el.textContent.trim()).catch(() => '0');
                rowData += `${data_hora}, `;

                // Extração dos times
                let timehome = await row.$eval(`div.duelParticipant__home > div.participant__participantNameWrapper > div.participant__participantName.participant__overflow > a`, el => el.textContent.trim()).catch(() => '');
                let timeaway = await row.$eval(`div.duelParticipant__away > div.participant__participantNameWrapper`, el => el.textContent.trim()).catch(() => '');

                let normalizedTeamId = normalizeString(teamId);
                let normalizedTimeHome = normalizeString(timehome);
                let normalizedTimeAway = normalizeString(timeaway);

                let normalizedTimeHome1 = normalizecoluna(timehome);
                let normalizedTimeAway2 = normalizecoluna(timeaway);

                console.log(`Time Casa Colunas: ${normalizedTimeHome1}`);
                console.log(`Time Visitante Colunas: ${normalizedTimeAway2}`);

                console.log(`Time: ${normalizedTeamId}`);
                console.log(`Time Casa: ${normalizedTimeHome}`);
                console.log(`Time Visitante: ${normalizedTimeAway}`);

                let isHome = normalizedTeamId === normalizedTimeHome;
                let isAway = normalizedTeamId === normalizedTimeAway;

                console.log(`Time Casa: ${isHome}`);
                console.log(`Time Visitante: ${isAway}`);

                rowData += `${normalizedTimeHome1 || '0'}, `;
                rowData += `${normalizedTimeAway2 || '0'}, `;

                let Resultadohome = await row.$eval(`div.duelParticipant > div.duelParticipant__score > div > div.detailScore__wrapper > span:nth-child(1)`, el => el.textContent.trim()).catch(() => '0');
                let Resultadoaway = await row.$eval(`div.duelParticipant > div.duelParticipant__score > div > div.detailScore__wrapper > span:nth-child(3)`, el => el.textContent.trim()).catch(() => '0');

                rowData += `${Resultadohome}, ${Resultadoaway}, `;
                console.log("Resultado Casa:", Resultadohome);
                console.log("Resultado Visitante:", Resultadoaway);

                let estatisticasJogo = {};
                const estatisticasEsperadas = [
                    "golos esperados (xg)", "posse de bola", "tentativas de golo", "remates à baliza",
                    "remates fora", "remates bloqueados", "grandes oportunidades", "cantos",
                    "remates dentro da área", "remates fora da área", "acertou na trave",
                    "defesas de guarda-redes", "livres", "foras de jogo", "faltas",
                    "cartões amarelos", "lançamentos", "toques na área adversária", "passes",
                    "passes no último terço", "cruzamentos", "desarmes", "intercepções"
                ];

                estatisticasEsperadas.forEach(stat => {
                    estatisticasJogo[stat] = '0';
                });

                try {
                    const section = await row.$('.section');
                    if (!section) throw new Error('Elemento .section não encontrado.');

                    const subsections = await section.$$('div[class*="row"]');
                    if (subsections.length === 0) throw new Error('Nenhuma subseção encontrada.');

                    console.log(`Encontradas ${subsections.length} subseções.`);

                    let normalizedEstatisticasEsperadas = estatisticasEsperadas.map(stat => normalizeString(stat));

                    for (let i = 0; i < estatisticasEsperadas.length && i < subsections.length; i++) {
                        const subsection = subsections[i];

                        try {
                            let statisticName = await subsection.$eval(`div[class*="category"]`, el => {
                                return el.textContent
                                    .replace(/[0-9%()\/]/g, '')
                                    .trim()
                                    .normalize("NFD").replace(/[\u0300-\u036f]/g, '')
                                    .toLowerCase();
                            });

                            let normalizedCategory = normalizeString(statisticName);

                            let estatisticaCorreta = estatisticasEsperadas.find(stat => {
                                return normalizedCategory === normalizeString(stat);
                            });

                            if (estatisticaCorreta) {
                                let valueSelector = isHome ? 'div[class*="homeValue"]' :
                                    isAway ? 'div[class*="awayValue"]' : '';

                                if (valueSelector) {
                                    let extractedValue = await subsection.$eval(valueSelector, el => el.textContent.trim()).catch(() => '0');

                                    estatisticasJogo[estatisticaCorreta] = extractedValue;
                                    console.log(`Estatística coletada: ${estatisticaCorreta} -> ${extractedValue}`);
                                }
                            } else {
                                console.warn(`Estatística inesperada encontrada: ${statisticName}`);
                            }

                        } catch (error) {
                            console.error(`Erro ao extrair estatísticas da subseção ${i + 1}:`, error);
                        }
                    }

                } catch (error) {
                    console.error('Erro ao extrair as subseções:', error);
                    if (error.message.includes("Nenhuma subseção encontrada")) {
                        estatisticasEsperadas.forEach(stat => {
                            estatisticasJogo[stat] = "0";
                        });
                        console.warn("Nenhuma estatística encontrada. Todas as estatísticas foram definidas como 0.");
                    }
                }

                teamData = {
                    data_hora: data_hora || null,
                    timehome: normalizecoluna(timehome) || null,
                    resultadohome: Resultadohome || 0,
                    timeaway: normalizecoluna(timeaway) || null,
                    resultadoaway: Resultadoaway || 0,
                    golos_esperados_xg: estatisticasJogo["golos esperados (xg)"] || 0,
                    posse_de_bola: estatisticasJogo["posse de bola"] || 0,
                    tentativas_de_golo: estatisticasJogo["tentativas de golo"] || 0,
                    remates_a_baliza: estatisticasJogo["remates à baliza"] || 0,
                    remates_fora: estatisticasJogo["remates fora"] || 0,
                    remates_bloqueados: estatisticasJogo["remates bloqueados"] || 0,
                    grandes_oportunidades: estatisticasJogo["grandes oportunidades"] || 0,
                    cantos: estatisticasJogo["cantos"] || 0,
                    remates_dentro_da_area: estatisticasJogo["remates dentro da área"] || 0,
                    remates_fora_da_area: estatisticasJogo["remates fora da área"] || 0,
                    acertou_na_trave: estatisticasJogo["acertou na trave"] || 0,
                    defesas_de_guarda_redes: estatisticasJogo["defesas de guarda-redes"] || 0,
                    livres: estatisticasJogo["livres"] || 0,
                    foras_de_jogo: estatisticasJogo["foras de jogo"] || 0,
                    faltas: estatisticasJogo["faltas"] || 0,
                    cartoes_amarelos: estatisticasJogo["cartões amarelos"] || 0,
                    lancamentos: estatisticasJogo["lançamentos"] || 0,
                    toques_na_area_adversaria: estatisticasJogo["toques na área adversária"] || 0,
                    passes: estatisticasJogo["passes"] || 0,
                    passes_no_ultimo_terco: estatisticasJogo["passes no último terço"] || 0,
                    cruzamentos: estatisticasJogo["cruzamentos"] || 0,
                    desarmes: estatisticasJogo["desarmes"] || 0,
                    intercepcoes: estatisticasJogo["intercepções"] || 0,
                };

                console.log("Dados coletados:", teamData);
                // Verificando se a data está correta antes de salvar
                console.log("🟢 Dados estruturados para salvar:", JSON.stringify(teamData, null, 2));

                // Antes de salvar, verificando se 'teamName' é uma string válida
                if (teamID10 && teamData.data_hora) {
                    if (typeof teamID10 === 'string' && teamID10.trim() !== '') {
                        await saveDataToPlayersTable(teamID10, teamData);
                        console.log(`✅ Dados salvos para o time ${teamID10}`);
                    } else {
                        console.log("⚠️ O nome do time (teamID10) não é válido. Nenhum dado foi salvo.");
                    }
                } else {
                    console.log("⚠️ Nenhum dado foi salvo. Verifique as estatísticas.");
                }

            }
        } catch (error) {
            console.error("Erro geral no scraping:", error);
        }
    }

    await browser.close();
};
// Exportando a função
module.exports = {
  fetchLinksFromDatabase1,
 scrapeResults10 
 
};
