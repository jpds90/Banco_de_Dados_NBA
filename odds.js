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
        headless: true, // Garante que o navegador rode em modo headless
        args: ['--no-sandbox', '--disable-setuid-sandbox'], // Evita restrições no ambiente do Render
    });
    const page = await browser.newPage();
    
    const currentDateTime = new Date();
    const tomorrowDateTime = new Date(currentDateTime);
    tomorrowDateTime.setDate(currentDateTime.getDate() + 1);
    
    const dayAfterTomorrowDateTime = new Date(currentDateTime);
    dayAfterTomorrowDateTime.setDate(currentDateTime.getDate() + 2);
    
    const todayStr = currentDateTime.toISOString().split('T')[0];
    const tomorrowStr = tomorrowDateTime.toISOString().split('T')[0];
    const dayAfterTomorrowStr = dayAfterTomorrowDateTime.toISOString().split('T')[0];
    
    console.log("Hoje:", todayStr);
    console.log("Amanhã:", tomorrowStr);
    console.log("Depois de amanhã:", dayAfterTomorrowStr);
    
    // Controle dinâmico da data alvo
    let searchDateStr = todayStr;
    
// Ajustar `isDateInRange` para comparar apenas datas (YYYY-MM-DD)
const isDateInRange = (gameDateStr) => {
    // Extrair apenas a parte da data de gameDateStr (YYYY-MM-DD)
    const gameDateOnly = gameDateStr.split(' ')[0]; // Remove o horário
    // Se a data do jogo é futura e está dentro do intervalo esperado, ajusta `searchDateStr`
    if (searchDateStr === todayStr && gameDateOnly > todayStr && gameDateOnly <= dayAfterTomorrowStr) {
        searchDateStr = tomorrowStr;
    } else if (searchDateStr === tomorrowStr && gameDateOnly > tomorrowStr && gameDateOnly <= dayAfterTomorrowStr) {
        searchDateStr = dayAfterTomorrowStr;
    }
    // Retorna true somente se `gameDateOnly` for igual ao `searchDateStr`
    return gameDateOnly === searchDateStr;
};
    // Função para tentar navegar com tentativas de re-execução
async function tryNavigate(url, page, maxRetries = 3) {
    for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
            await page.goto(url, { timeout: 180000 }); // Ajustando o timeout
            return; // Se a navegação for bem-sucedida, sai da função
        } catch (error) {
            if (error.name === 'TimeoutError' && attempt < maxRetries) {
                console.log(`Timeout na tentativa ${attempt} para ${url}. Tentando novamente...`);
                await sleep(5000); // Esperar 5 segundos antes de tentar novamente
            } else {
                console.error(`Erro ao navegar para ${url} após ${maxRetries} tentativas:`, error);
                throw error; // Lança o erro se o número máximo de tentativas for atingido
            }
        }
    }
}

    

    try {
        await tryNavigate('https://www.flashscore.pt/basquetebol/eua/nba/lista/', page);
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

// Processamento do loop
for (let id of ids) {
    const summaryUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds/`;
    console.log("Processando URL de resumo:", summaryUrl);
    await tryNavigate(summaryUrl, page2);
    await sleep(10000);

    let dataJogo = '';
    let gameDateStr = '';
    let timeHome = '';
    let timeAway = '';

    try {
        dataJogo = await page2.$eval(
            `div.duelParticipant__startTime`,
            (element) => element.textContent.trim()
        );
        
        // Divide a string em duas partes: data (ex.: "13.12.") e hora (ex.: "00:30")
        const [datePart, time] = dataJogo.split(' '); // Divide em data e hora
        const [day, month] = datePart.split('.'); // Extrai dia e mês
        
        // Obtém o ano atual
        let year = new Date().getFullYear();
        
        // Corrige o ano se o mês do jogo for menor que o mês atual
        const currentMonth = new Date().getMonth() + 1; // `getMonth()` retorna 0 para janeiro
        if (parseInt(month) < currentMonth) {
            year += 1; // Avança para o próximo ano
        }
        
        // Converte para o formato compatível com PostgreSQL (YYYY-MM-DD HH:mm)
        gameDateStr = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;
        
        console.log(`Data do jogo ajustada: ${gameDateStr}`);
        

        // Verificar se a data está no intervalo
        if (!isDateInRange(gameDateStr)) {
            console.log(`Jogo com ID ${id} fora do intervalo. Data: ${gameDateStr}`);

            // Salvar os dados antes de encerrar
            if (futureGamesData.length > 0) {
                try {
                    console.log("Salvando dados antes de encerrar...");
                    await saveToDatabase(futureGamesData);
                } catch (error) {
                    console.error('Erro ao salvar no banco de dados:', error);
                }
            }

            console.log("Encerrando processamento devido à data fora do intervalo.");
            break; // Sair do laço for
        }

        // Processar informações do jogo
        timeHome = await page2.$eval(
            `div.duelParticipant__home .participant__participantName a`,
            (element) => element.textContent.trim()
        );
        console.log(`Time da casa: ${timeHome}`);

        timeAway = await page2.$eval(
            `div.duelParticipant__away .participant__participantName`,
            (element) => element.textContent.trim()
        );
        console.log(`Time visitante: ${timeAway}`);
    } catch (error) {
        console.error('Erro ao processar a página de resumo:', error);
        continue;
    }

    if (!gameDateStr) {
        console.error(`Data inválida para o jogo com ID ${id}. Ignorando entrada.`);
        continue;
    }

            const oddsUrl = `https://www.flashscore.pt/jogo/${id.substring(4)}/#/comparacao-de-odds`;
            console.log("Processando URL de odds 1x2:", oddsUrl);
            await tryNavigate(oddsUrl, page2);
            await sleep(10000);

            let homeOdds = '';
            let awayOdds = '';

            try {
                // Selecionando os odds diretamente pelos novos seletores
                const homeOddsElement = await page2.$('#detail > div:nth-child(7) > div > div.oddsTab__tableWrapper > div > div.ui-table__body > div > a:nth-child(2) > span');
                const awayOddsElement = await page2.$('#detail > div:nth-child(7) > div > div.oddsTab__tableWrapper > div > div.ui-table__body > div > a:nth-child(3) > span');
                
                if (homeOddsElement && awayOddsElement) {
                    homeOdds = await homeOddsElement.evaluate((element) => element.textContent.trim());
                    awayOdds = await awayOddsElement.evaluate((element) => element.textContent.trim());
                    
                    console.log(`Odds casa: ${homeOdds}, Odds visitante: ${awayOdds}`);
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
            await tryNavigate(oddsmaisemenosUrl, page2);
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
                            overOdds = parseInt(overOdds); // Remove a parte decimal
                        }
                    }
                }
            } catch (error) {
                console.error('Erro ao processar a página de odds mais de/menos de:', error);
                continue;
            }
            try {
                const oddsTableWrapper = await page2.$('.oddsTab__tableWrapper');
                const oddsTables = await oddsTableWrapper.$$('.ui-table.oddsCell__odds');
        
                if (oddsTables.length > 0) {
                    const targetTable = oddsTables[0];
                    
                const maisMenosRows = await page2.$$('.ui-table__body .ui-table__row');
            
                if (maisMenosRows.length > 0) {
                    const maisMenosRow = maisMenosRows[0];
                    const oddsCells = await maisMenosRow.$$('.oddsCell__noOddsCell');
                        if (oddsCells.length > 0) {
                            overOdds = await oddsCells[0].evaluate(element => element.textContent.trim());
                            overOdds = parseInt(overOdds); // Remove a parte decimal

                         console.log(`Ponto ${overOdds}, Odds  ${overDoisMeioOdds}`);
                        }
                    }
                }
            } catch (error) {
                console.error('Erro ao processar a página de odds mais de/menos de:', error);
                continue;
            }
            futureGamesData.push({
                dataJogo: gameDateStr || 0, // Substitua por NULL se o valor estiver vazio
                timeHome: timeHome || 'Indefinido',
                timeAway: timeAway || 'Indefinido',
                homeOdds: isNaN(homeOdds) ? 0 : parseFloat(homeOdds), // Certifique-se de que é numérico
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
