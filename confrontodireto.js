const { Pool } = require('pg');

// Configuração do banco de dados
const pool = new Pool({
 connectionString: process.env.DATABASE_URL, // Usando a URL completa
  ssl: { rejectUnauthorized: false },
});

(async () => {
    try {
        // Buscar os dados da tabela odds
        const oddsResult = await pool.query('SELECT time_home, time_away FROM odds');
        const oddsRows = oddsResult.rows;

        for (const { time_home, time_away } of oddsRows) {
            const homeTable = time_home.toLowerCase().replace(/\s/g, '_');

            console.log(`Processando os times: Home - ${time_home}, Away - ${time_away}`);
            console.log(`Tabela esperada: ${homeTable}`);

            const confrontationResult = await pool.query(`
                SELECT home_score, away_score, home_team, away_team
                FROM ${homeTable}
                WHERE (home_team = $1 AND away_team = $2)
                   OR (home_team = $2 AND away_team = $1)
                ORDER BY id ASC
            `, [time_home, time_away]);

            let homeWins = 0;
            let awayWins = 0;

            console.log(`Confrontos encontrados entre ${time_home} e ${time_away}:`);
            confrontationResult.rows.forEach((row, index) => {
                const homeScore = parseInt(row.home_score, 10);
                const awayScore = parseInt(row.away_score, 10);

                console.log(`Confronto ${index + 1}: ${row.home_team} - ${homeScore} x ${row.away_team} - ${awayScore}`);

                // Verificar quem venceu o confronto
                if (homeScore > awayScore && row.home_team === time_home) {
                    homeWins++;
                } else if (awayScore > homeScore && row.away_team === time_away) {
                    awayWins++;
                }
            });

            console.log(`Total de vitórias:`);
            console.log(`${time_home}: ${homeWins}`);
            console.log(`${time_away}: ${awayWins}`);
        }
    } catch (error) {
        console.error('Erro ao processar os dados:', error);
    } finally {
        await pool.end();
    }
})();
