require('dotenv').config();
const puppeteer = require('puppeteer');
const { Pool } = require('pg');
const sleep = require('sleep-promise');



// Configuração do pool de conexão ao banco de dados
const pool = new Pool({
 connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});
// Função para obter a última data do banco de dados
const getLastDateFromDatabase = async (teamTable) => {
    const client = await pool.connect();
    try {
        console.log(`Buscando a última data na tabela ${teamTable}...`);
        const result = await client.query(`SELECT data_hora FROM "${teamTable}" ORDER BY data_hora DESC LIMIT 1`);
        if (result.rows.length > 0) {
            console.log(`Última data encontrada para a tabela ${teamTable}: ${result.rows[0].data_hora}`);
            return result.rows[0].data_hora;
        } else {
            console.log(`Nenhuma data encontrada na tabela ${teamTable}`);
            return null;
        }
    } catch (error) {
        console.error(`Erro ao buscar a última data na tabela ${teamTable}:`, error);
        return null;
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
// Função para salvar os dados no banco
// Função para criar a tabela de jogadores para o time
const createPlayersTable = async (teamName) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();

        console.log(`Verificando a criação da tabela "jogadores" para o time: "${teamName}"...`);

    `);
    await client.query(`
        CREATE TABLE "${tableName}" (
                data_hora VARCHAR(50) NOT NULL,
                id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                player_name VARCHAR(255) NOT NULL,
                team VARCHAR(255),
                points INT,
                total_rebounds INT,
                assists INT,
                minutes_played INT,
                field_goals_made INT,
                field_goals_attempted INT,
                two_point_made INT,
                two_point_attempted INT,
                three_point_made INT,
                three_point_attempted INT,
                free_throws_made INT,
                free_throws_attempted INT,
                plus_minus INT,
                offensive_rebounds INT,
                defensive_rebounds INT,
                personal_fouls INT,
                steals INT,
                turnovers INT,
                shots_blocked INT,
                blocks_against INT,
                technical_fouls INT
                )
            `);
            console.log(`Tabela "jogadores" criada para o time: "${teamName}".`);
    } catch (error) {
        console.error(`Erro ao criar tabela para o time "${teamName}":`, error);
    } finally {
        client.release();
    }
};



// Função para salvar os dados dos jogadores
const saveDataToPlayersTable = async (teamName, data) => {
    const client = await pool.connect();
    try {
        const tableName = teamName.replace(/[^a-zA-Z0-9]/g, "_").toLowerCase();
        console.log(`Salvando dados de jogadores na tabela "${tableName}"...`);
        
        for (const item of data) {
            // Usando `ON CONFLICT` para evitar duplicação ou atualizar
            await client.query(
                `
                INSERT INTO ${tableName} (
                    data_hora, team, player_name, points, total_rebounds, assists, minutes_played,
                    field_goals_made, field_goals_attempted, two_point_made, two_point_attempted,
                    three_point_made, three_point_attempted, free_throws_made, free_throws_attempted,
                    plus_minus, offensive_rebounds, defensive_rebounds, personal_fouls,
                    steals, turnovers, shots_blocked, blocks_against, technical_fouls
                ) VALUES (
                    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24
                )
                ON CONFLICT (data_hora, player_name) DO UPDATE
                SET
                    team = EXCLUDED.team,
                    points = EXCLUDED.points,
                    total_rebounds = EXCLUDED.total_rebounds,
                    assists = EXCLUDED.assists,
                    minutes_played = EXCLUDED.minutes_played,
                    field_goals_made = EXCLUDED.field_goals_made,
                    field_goals_attempted = EXCLUDED.field_goals_attempted,
                    two_point_made = EXCLUDED.two_point_made,
                    two_point_attempted = EXCLUDED.two_point_attempted,
                    three_point_made = EXCLUDED.three_point_made,
                    three_point_attempted = EXCLUDED.three_point_attempted,
                    free_throws_made = EXCLUDED.free_throws_made,
                    free_throws_attempted = EXCLUDED.free_throws_attempted,
                    plus_minus = EXCLUDED.plus_minus,
                    offensive_rebounds = EXCLUDED.offensive_rebounds,
                    defensive_rebounds = EXCLUDED.defensive_rebounds,
                    personal_fouls = EXCLUDED.personal_fouls,
                    steals = EXCLUDED.steals,
                    turnovers = EXCLUDED.turnovers,
                    shots_blocked = EXCLUDED.shots_blocked,
                    blocks_against = EXCLUDED.blocks_against,
                    technical_fouls = EXCLUDED.technical_fouls
                `,
                [
                    item.datahora, item.team, item.playerName, item.points, item.totalRebounds, item.assists,
                    item.minutesPlayed, item.fieldGoalsMade, item.fieldGoalsAttempted,
                    item.twoPointMade, item.twoPointAttempted, item.threePointMade,
                    item.threePointAttempted, item.freeThrowsMade, item.freeThrowsAttempted,
                    item.plusMinus, item.offensiveRebounds, item.defensiveRebounds,
                    item.personalFouls, item.steals, item.turnovers, item.shotsBlocked,
                    item.blocksAgainst, item.technicalFouls,
                ]
            );
            console.log(`Dados salvos/atualizados para o jogador: ${item.playerName}`);
        }
    } catch (error) {
        console.error(`Erro ao salvar dados na tabela "${tableName}":`, error);
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
const scrapeResults1 = async (link) => {
    const data = [];
    console.log(`Iniciando o scraping para o link: ${link}`);

    const fullLink = `${link}resultados/`;
    console.log('Link completo para scraping:', fullLink);

        const browser = await puppeteer.launch({
        headless: true, // Garante que o navegador rode em modo headless
        args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições no ambiente do Render
    });
    const page = await browser.newPage();
    console.log('Abrindo o navegador e indo para a página...', fullLink);
    await loadPageWithRetries(page, fullLink);

    const url = await page.evaluate(() => window.location.href);

    console.log('URL capturada:', url);

    // Definir os índices para extrair o nome do time
    const startIndex = url.indexOf("/equipa/") + "/equipa/".length;
    const endIndex = url.indexOf("/", startIndex);
    console.log('startIndex:', startIndex);
    console.log('endIndex:', endIndex);

    // Extrair e formatar o nome do time para utilizar como ID da tabela
    let teamID10 = null;

    if (startIndex !== -1 && endIndex !== -1) {
        teamID10 = `${url.substring(startIndex, endIndex).replace(/-/g, '_').toLowerCase()}_jogadores`;
        console.log(`ID do time processado: ${teamID10}`);
    } else {
        console.log('Erro ao extrair o ID da equipe.');
    }

    // Extrai o ID da equipe da URL
    const start_index = url.indexOf("/equipa/") + "/equipa/".length;
    const end_index = url.indexOf("/", start_index);
    const teamId = url.substring(start_index, end_index).replace(/-/g, ' ');
    console.log(teamId);
    
    // Extrai o ID da equipe da URL
    const start_index1 = url.indexOf("/equipa/") + "/equipa/".length;
    const end_index1 = url.indexOf("/", start_index1);
    const teamId1 = url.substring(start_index1, start_index1 + 3);
    console.log(teamId1);
    
    
    const start_index2 = url.indexOf("/equipa/") + "/equipa/".length;
    const equipa = url.substring(start_index2);
    const equipeId = equipa.substring(0, 2); // Obtém os dois primeiros caracteres
    const lac1 = equipa.substring(equipa.indexOf("-") + 1).charAt(0); // Obtém o primeiro caractere após o primeiro "-"
    const equipeSigla = equipeId + lac1;
    console.log(equipeSigla);
    
    
    const start_index3 = url.indexOf("/equipa/") + "/equipa/".length;
    const equipa1 = url.substring(start_index3);
    const equipeId3 = equipa1.charAt(0);
    const lac3 = equipa1.substring(equipa1.indexOf("-") + 1).charAt(0);
    const lac4 = equipa1.substring(equipa1.indexOf("-", equipa1.indexOf("-") + 1) + 1).charAt(0);
    const equipeSigla1 = equipeId3 + lac3 + lac4;
    console.log(equipeSigla1);
    

   // Wait for the classification table to load
   await sleep(5000);
        // Esperar o seletor principal com lógica de tentativas
        await waitForSelectorWithRetries(page, '.container', { timeout: 90000 });


   const ids = await page.evaluate(() => {
     const container = document.querySelector('.container');
     if (!container) {
       throw new Error('container não encontrado');
     }
     const containercontent = container.querySelector('.container__content.content');
     if (!containercontent) {
       throw new Error('Container Content não encontrado');
     }
     const containerMain = containercontent.querySelector('.container__main');
     if (!containerMain) {
       throw new Error('containerMain não encontrado');
     }
     const containerMainInner = containerMain.querySelector('.container__mainInner');
     if (!containerMainInner) {
       throw new Error('ContainerMainInner não encontrado');
     }
     const containerLiveTable = containerMainInner.querySelector('.container__livetable');
     if (!containerLiveTable) {
       throw new Error('ContainerLiveTable não encontrado');
     }
     const containerFsbody = containerLiveTable.querySelector('.container__fsbody');
     if (!containerFsbody) {
       throw new Error('ContainerFsbody não encontrado');
     }
     const teamPage = containerFsbody.querySelector('.teamPage');
     if (!teamPage) {
       throw new Error('teamPage não encontrado');
     }
     const leaguesLive = teamPage.querySelector('.ui-section.event.ui-section--noIndent');
     if (!leaguesLive) {
       throw new Error('leguesLive não encontrado');
     }
     const sportName = leaguesLive.querySelector('.sportName.basketball');
     if (!sportName) {
       throw new Error('SportName não encontrado');
     }
     const ids = [];
     sportName.querySelectorAll('[id]').forEach(element => {
       ids.push(element.id);
     });
     return ids.slice(0, 12);
   });

   try {
    console.log(ids);

    // Loop para processar os IDs
    for (let i = 0; i < ids.length; i++) {
        try {
            const id = ids[i]; // Cada ID extraído
            const playerLink = `https://www.flashscore.pt/jogo/${ids[i].substring(4)}/#/sumario-do-jogo/player-statistics/`;
            console.log(`Processando o link do jogador com ID: ${id}`);

            // Abrir uma nova aba para cada jogador
            const playerPage = await browser.newPage();
            await playerPage.goto(playerLink, { timeout: 120000 });
            await sleep(5000); // Atraso para garantir que a página carregue

            // Processar estatísticas apenas se o teamID10 for válido
            if (teamID10) {
                const lastDate = await getLastDateFromDatabase(teamID10);
                console.log(`Última data encontrada para a tabela ${teamID10}: ${lastDate}`);

                // Extrair a data da página
                const statisticElement = await playerPage.$('#detail > div.duelParticipant > div.duelParticipant__startTime');
                if (statisticElement) {
                    const statisticData = await playerPage.evaluate(el => el.textContent.trim(), statisticElement);
                    console.log(`Data ${statisticData} encontrada!`);

                    if (lastDate && statisticData === lastDate) {
                        console.log(`A data ${statisticData} já foi registrada. Pulando para o próximo jogador.`);
                            await playerPage.close();
                            return;
                    }
                }
            }
        // Espera os seletores problemáticos com lógica de repetição
        await waitForSelectorWithRetries(playerPage, '#detail > div.subFilterOver.subFilterOver--indent > div > a:nth-child(2) > button', { timeout: 5000 });
        await waitForSelectorWithRetries(playerPage, '#detail > div.subFilterOver.subFilterOver--indent > div > a:nth-child(3) > button', { timeout: 5000 });


       // Processamento do botão 1
       const element1 = await playerPage.$('#detail > div.subFilterOver.subFilterOver--indent > div > a:nth-child(2) > button');
       const boundingBox1 = await element1.boundingBox();
       const textContent1 = await playerPage.evaluate(el => el.textContent.toLowerCase(), element1);

       // Processamento do botão 2
       const element2 = await playerPage.$('#detail > div.subFilterOver.subFilterOver--indent > div > a:nth-child(3) > button');
       const boundingBox2 = await element2.boundingBox();
       const textContent2 = await playerPage.evaluate(el => el.textContent.toLowerCase(), element2);

       // Lógica para clicar nos botões
       if (teamId.toLowerCase() === textContent1) {
           if (boundingBox1) {
               await playerPage.mouse.click(boundingBox1.x + boundingBox1.width / 2, boundingBox1.y + boundingBox1.height / 2);
               console.log(`Cliquei no botão correspondente ao teamId: ${teamId}`);

               // Gerar o link para o botão 1
               const link1 = `https://www.flashscore.pt/jogo/${ids[i].substring(4)}/#/sumario-do-jogo/player-statistics/1`;
               console.log(`Link gerado para o botão 1: ${link1}`);
               await playerPage.goto(link1, { waitUntil: 'load', timeout: 60000 });
           }
       } else if (teamId.toLowerCase() === textContent2) {
           if (boundingBox2) {
               await playerPage.mouse.click(boundingBox2.x + boundingBox2.width / 2, boundingBox2.y + boundingBox2.height / 2);
               console.log(`Cliquei no botão correspondente ao teamId: ${teamId}`);

               // Gerar o link para o botão 2
               const link2 = `https://www.flashscore.pt/jogo/${ids[i].substring(4)}/#/sumario-do-jogo/player-statistics/2`;
               console.log(`Link gerado para o botão 2: ${link2}`);
               await playerPage.goto(link2, { waitUntil: 'load', timeout: 60000 });
           }
       } else {
           console.log(`Nenhum botão corresponde ao teamId: ${teamId}`);
       }

       // Esperar os dados da tabela de estatísticas
       await playerPage.waitForSelector('#detail > div.section.psc__section > div > div.ui-table.playerStatsTable > div.ui-table__body > div');
       const rows = await playerPage.$$(`#detail > div.section.psc__section > div > div.ui-table.playerStatsTable > div.ui-table__body > div`);
       await sleep(10000); // Atraso para garantir o carregamento dos dados


       // Função para converter o formato "MM:SS" para total de segundos
function convertMinutesToSeconds(timeString) {
    if (!timeString) return 0; // Valor padrão caso esteja vazio ou indefinido
    const [minutes, seconds] = timeString.split(':').map(Number); // Quebra o texto em minutos e segundos
    if (isNaN(minutes) || isNaN(seconds)) {
        console.error(`Erro ao converter o tempo "${timeString}" para segundos.`);
        return 0; // Retorna 0 caso não seja possível converter para número
    }
    return (minutes * 60) + seconds; // Converte para total de segundos
}

       // Função para processar as estatísticas dos jogadores

       for (const row of rows) {
        try {
            const team = await row.$eval(
                `div.playerStatsTable__cell.playerStatsTable__teamCell`,
                element => element.textContent.trim()
            );
            const playerName = await row.$eval(`a > div`, element => element.textContent.trim());
            const points = parseInt(await row.$eval(`div.playerStatsTable__cell.playerStatsTable__cell--sortingColumn`, element => element.textContent.trim())) || 0;
            const totalRebounds = parseInt(await row.$eval(`div:nth-child(4)`, element => element.textContent.trim())) || 0;
            const assists = parseInt(await row.$eval(`div:nth-child(5)`, element => element.textContent.trim())) || 0;
    
            const minutesPlayedRaw = await row.$eval(`div:nth-child(6)`, element => element.textContent.trim());
            const minutesPlayed = convertMinutesToSeconds(minutesPlayedRaw);
    
            const fieldGoalsMade = parseInt(await row.$eval(`div:nth-child(7)`, element => element.textContent.trim())) || 0;
            const fieldGoalsAttempted = parseInt(await row.$eval(`div:nth-child(8)`, element => element.textContent.trim())) || 0;
            const twoPointMade = parseInt(await row.$eval(`div:nth-child(9)`, element => element.textContent.trim())) || 0;
            const twoPointAttempted = parseInt(await row.$eval(`div:nth-child(10)`, element => element.textContent.trim())) || 0;
            const threePointMade = parseInt(await row.$eval(`div:nth-child(11)`, element => element.textContent.trim())) || 0;
            const threePointAttempted = parseInt(await row.$eval(`div:nth-child(12)`, element => element.textContent.trim())) || 0;
            const freeThrowsMade = parseInt(await row.$eval(`div:nth-child(13)`, element => element.textContent.trim())) || 0;
            const freeThrowsAttempted = parseInt(await row.$eval(`div:nth-child(14)`, element => element.textContent.trim())) || 0;
            const plusMinus = parseInt(await row.$eval(`div:nth-child(15)`, element => element.textContent.trim())) || 0;
            const offensiveRebounds = parseInt(await row.$eval(`div:nth-child(16)`, element => element.textContent.trim())) || 0;
            const defensiveRebounds = parseInt(await row.$eval(`div:nth-child(17)`, element => element.textContent.trim())) || 0;
            const personalFouls = parseInt(await row.$eval(`div:nth-child(18)`, element => element.textContent.trim())) || 0;
            const steals = parseInt(await row.$eval(`div:nth-child(19)`, element => element.textContent.trim())) || 0;
            const turnovers = parseInt(await row.$eval(`div:nth-child(20)`, element => element.textContent.trim())) || 0;
            const shotsBlocked = parseInt(await row.$eval(`div:nth-child(21)`, element => element.textContent.trim())) || 0;
            const blocksAgainst = parseInt(await row.$eval(`div:nth-child(22)`, element => element.textContent.trim())) || 0;
            const technicalFouls = parseInt(await row.$eval(`div:nth-child(23)`, element => element.textContent.trim())) || 0;
    
            // Verifica se há data e define valor 0 se não houver
            const statisticElement = await playerPage.$('#detail > div.duelParticipant > div.duelParticipant__startTime');
            const statisticData = statisticElement
                ? await playerPage.evaluate(element => element.textContent.trim(), statisticElement)
                : "0"; // Valor 0 caso não encontre a data
    
            const playerStats = {
                datahora: statisticData,
                team,
                playerName,
                points,
                totalRebounds,
                assists,
                minutesPlayed,
                fieldGoalsMade,
                fieldGoalsAttempted,
                twoPointMade,
                twoPointAttempted,
                threePointMade,
                threePointAttempted,
                freeThrowsMade,
                freeThrowsAttempted,
                plusMinus,
                offensiveRebounds,
                defensiveRebounds,
                personalFouls,
                steals,
                turnovers,
                shotsBlocked,
                blocksAgainst,
                technicalFouls,
            };
    
            data.push(playerStats);
            console.log(`Dados salvos para o jogador: ${playerName}`);
        } catch (error) {
            console.error("Erro ao processar jogador:", error);
        }
    }
                    // Salvar dados no banco antes de fechar a página
                if (teamID10 && data.length > 0) {
                    await saveDataToPlayersTable(teamID10, data); // Função de salvamento
                    console.log(`Dados salvos para o time ${teamID10}`);
                }
            // Fechar a página de cada jogador
            await playerPage.close();
        } catch (error) {
            console.error(`Erro ao processar o jogador com ID ${ids[i]}:`, error);
            console.log('Pulando para o próximo jogador...');
            continue; // Pula para o próximo jogador no loop
        }
    }
} catch (error) {
    console.error("Erro geral no processamento:", error);
}
// Extrai o nome do time do link
const rawTeamName = link.split('/').slice(-3, -2)[0]; // Obtém o nome bruto do time
const teamName = rawTeamName.replace('-', ' '); // Formata para exibição (ex.: "los angeles-lakers" -> "los angeles lakers")
const normalizedTeamName = rawTeamName.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase() + '_jogadores'; // Normaliza para uso no banco (ex.: "los angeles-lakers" -> "los_angeles_lakers")

console.log(`Time identificado a partir do link: ${teamName}`);

// Cria a tabela apenas para o time do link
await createPlayersTable(normalizedTeamName); // Cria a tabela para os jogadores
await saveDataToPlayersTable(normalizedTeamName, data); // Salva os dados dos jogadores

console.log(`Scraping finalizado para o link: ${link}`);
await browser.close();

};
// Função principal
if (require.main === module) {
    (async () => {
        try {
            console.log("Executando script.js...");

            const links = await fetchLinksFromDatabase();

            // Log dos links no console
            console.log('Links obtidos do banco de dados:', links);

            if (links.length === 0) {
                console.log('Nenhum link encontrado para processamento.');
                process.exit(0); // Nada a fazer, mas encerra com sucesso
            }

            for (const link of links) {
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
module.exports = { scrapeResults1 };
