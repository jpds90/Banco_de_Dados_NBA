const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

// Configuração do pool de conexão com o banco de dados
const pool = new Pool({
  connectionString: process.env.DATABASE_URL, // URL do banco de dados configurada no .env
  ssl: { rejectUnauthorized: false },
});

async function runScript() {
  try {
    // Lê o arquivo SQL
    const sql = fs.readFileSync(path.join(__dirname, 'alter_tables_auto_increment.sql'), 'utf8');

    // Executa o script SQL
    const client = await pool.connect();
    await client.query(sql);
    console.log("Script executado com sucesso!");
    client.release();
  } catch (error) {
    console.error("Erro ao executar o script SQL:", error);
  }
}

// Executa a função
runScript();
