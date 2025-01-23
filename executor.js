const fs = require('fs');
const { exec } = require('child_process');

const scripts = ['script.js', 'jogadores.js', 'lesoes.js']; // Lista dos scripts a serem executados
const progressFile = 'progress.json'; // Arquivo para salvar o progresso
const maxRetries = 4; // Número máximo de tentativas

// Função para salvar o progresso
const saveProgress = (scriptName, status, retries) => {
    let progress = {};
    if (fs.existsSync(progressFile)) {
        progress = JSON.parse(fs.readFileSync(progressFile, 'utf-8'));
    }
    progress[scriptName] = { status, retries };
    fs.writeFileSync(progressFile, JSON.stringify(progress));
};

// Função para carregar o progresso
const loadProgress = () => {
    if (fs.existsSync(progressFile)) {
        return JSON.parse(fs.readFileSync(progressFile, 'utf-8'));
    }
    return {};
};

// Função para executar um script com tentativas e intervalos
const executeScript = async (scriptName) => {
    const progress = loadProgress();
    const retries = progress[scriptName]?.retries || 0;

    if (retries >= maxRetries) {
        console.log(`Máximo de tentativas atingido para ${scriptName}.`);
        return;
    }

    try {
        console.log(`Executando ${scriptName}, tentativa ${retries + 1}...`);
        await new Promise((resolve, reject) => {
            exec(`node ${scriptName}`, (error, stdout, stderr) => {
                if (error) {
                    console.error(`Erro no script ${scriptName}:`, stderr);
                    return reject(error);
                }
                console.log(`Saída de ${scriptName}:`, stdout);
                resolve();
            });
        });

        // Se o script for executado com sucesso
        saveProgress(scriptName, 'completed', 0); // Resetando as tentativas
        console.log(`${scriptName} concluído com sucesso.`);
    } catch (error) {
        const nextRetries = retries + 1;
        saveProgress(scriptName, 'failed', nextRetries);

        if (nextRetries < maxRetries) {
            const delay = nextRetries === 3 ? 60000 : 5000; // 3ª tentativa: 1 minuto; outras: 5 segundos
            console.log(`Tentativa ${nextRetries} falhou para ${scriptName}. Nova tentativa em ${delay / 1000} segundos.`);
            setTimeout(() => executeScript(scriptName), delay);
        } else {
            console.error(`Todas as tentativas falharam para ${scriptName}.`);
        }
    }
};

// Executar os scripts em sequência
(async () => {
    const progress = loadProgress();
    for (const script of scripts) {
        if (progress[script]?.status === 'completed') {
            console.log(`Pulando ${script}, já foi concluído.`);
            continue;
        }
        await executeScript(script);
    }
    console.log("Execução completa para todos os scripts.");
})();
