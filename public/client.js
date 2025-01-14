

const loginForm = document.getElementById('login-form');
const protectedDataDiv = document.getElementById('protected-data');
const betHistoryDiv = document.getElementById('bet-history');
const loggedInUserElement = document.getElementById('loggedInUser'); // Elemento para exibir o nome do usuário
const logoutButton = document.getElementById('logoutButton'); // Botão de logout
const daysOptionInput = document.getElementById('daysOption');
const daysInput = document.getElementById('days');
const bankrollInput = document.getElementById('bankroll');
const targetProfitInput = document.getElementById('targetProfit');

// Salvar o token do usuário
let authToken = null;

// Função para obter o user_id do token
function getUserIdFromToken(token) {
    try {
        const decoded = jwt_decode(token);
        return decoded.userId;
    } catch (error) {
        console.error('Erro ao decodificar o token:', error);
        return null;
    }
}

// Função para mostrar o loader
function showLoader(message) {
    const loader = document.getElementById('loader');
    loader.style.display = 'block';
    loader.textContent = message || 'Carregando...';
}

// Função para esconder o loader
function hideLoader() {
    const loader = document.getElementById('loader');
    loader.style.display = 'none';
}

// Função reutilizável para fetch com autenticação
async function fetchWithAuth(url, options) {
    let token = localStorage.getItem('authToken');

    const response = await fetch(url, {
        ...options,
        headers: {
            ...options.headers,
            Authorization: `Bearer ${token}`
        }
    });

    if (response.status === 401) {
        const data = await response.json();
        if (data.message === 'Token expirado') {
            const newToken = data.newToken;
            localStorage.setItem('authToken', newToken);

            // Reenvia a requisição com o novo token
            return fetch(url, {
                ...options,
                headers: {
                    ...options.headers,
                    Authorization: `Bearer ${newToken}`
                }
            });
        }
    }

    return response;
}

// Função de Login
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('login-email').value;
    const password = document.getElementById('login-password').value;

    showLoader('Fazendo login...');

    try {
        const response = await fetch('/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        const data = await response.json();
        hideLoader();

        if (response.ok) {
            authToken = data.token;
            localStorage.setItem('userName', data.username); // Salva o nome do usuário
            localStorage.setItem('authToken', authToken);
            

            const userId = getUserIdFromToken(authToken);
            localStorage.setItem('userId', userId); // Salva o userId no localStorage
            console.log('User ID:', userId);
            updateUserUI();
            alert('Login realizado com sucesso!');

            displayBetHistory();
            loadUserPlanning();
        } else {
            alert(data.message);
        }
    } catch (error) {
        console.error('Erro no login:', error);
        hideLoader();
    }
});

// Atualizar a interface com o nome do usuário e botão de logout
function updateUserUI() {
    const userName = localStorage.getItem('userName'); // Recupera o nome do usuário do localStorage

    if (userName) {
        loggedInUserElement.textContent = `Bem-vindo, ${userName}`; // Exibe o nome do usuário
        logoutButton.style.display = 'inline-block'; // Torna o botão de logout visível
    } else {
        loggedInUserElement.textContent = 'Usuário não logado'; // Exibe mensagem padrão
        logoutButton.style.display = 'none'; // Oculta o botão de logout
    }
}

// Função de Logout
logoutButton.addEventListener('click', () => {
    localStorage.removeItem('userName'); // Remove o nome do usuário do localStorage
    authToken = null; // Remove o token de autenticação
    alert('Você foi desconectado!');
    
    // Atualiza a página
    window.location.reload(); // Recarrega a página para redefinir o estado
});

// Carregar Dados Protegidos
async function loadProtectedData() {
    try {
        const response = await fetchWithAuth('/protected', {
            method: 'GET'
        });
        const data = await response.json();

        if (response.ok) {
            protectedDataDiv.style.display = 'block';
            displayBetHistory(); // Exibe o histórico de apostas
        } else {
            alert(data.message || 'Erro ao carregar dados protegidos.');
        }
    } catch (error) {
        console.error('Erro ao carregar dados protegidos:', error);
    }
}

// Exibir Histórico de Apostas
async function displayBetHistory() {
    const authToken = localStorage.getItem('authToken'); // Recupera o token do armazenamento local

    if (!authToken) {
        alert('Você precisa estar logado para ver o histórico.');
        return;
    }

    showLoader('Carregando histórico de apostas...');
    try {
        const response = await fetchWithAuth('/get-bet-history', {
            headers: { Authorization: `Bearer ${authToken}` }
        });
        const data = await response.json();
        hideLoader();

        if (response.ok) {
            const historyTable = document.getElementById('historyTable');
            historyTable.innerHTML = ''; // Limpa a tabela antes de adicionar novas apostas

            data.bets.forEach(bet => {
                // Calcula o lucro como fallback se não for enviado pelo backend
                let profit = parseFloat(bet.Lucro); // Backend deveria enviar este valor
                if (isNaN(profit)) {
                    profit = bet.outcome === 'Vencedor'
                        ? (parseFloat(bet.bet_value) * (parseFloat(bet.odds) - 1)).toFixed(2)
                        : '0.00';
                }

                // Criação de uma nova linha na tabela para cada aposta
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>
                        ${bet.game_date
                            .split('<br>')
                            .map(date => new Date(date).toLocaleString('pt-BR', {
                                day: '2-digit',
                                month: '2-digit',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                            }))
                            .join('<br>')}
                    </td>
                    <td>${bet.games.replaceAll('<br>', '<br>')}</td>
                    <td>${bet.choices}</td>
                    <td>${parseFloat(bet.odds).toFixed(2)}</td>
                    <td>R$ ${parseFloat(bet.bet_value).toFixed(2)}</td>
                    <td>R$ ${profit}</td>
                    <td>${bet.outcome === 'Vencedor' ? '✅' : '❌'}</td>
                `;

                // Adiciona a nova linha na tabela
                historyTable.appendChild(row);
            });
        } else {
            alert(data.message || 'Erro ao carregar histórico.');
        }
    } catch (error) {
        console.error('Erro ao carregar histórico de apostas:', error);
        hideLoader();
    }
}



// Atualizar a interface ao carregar a página
document.addEventListener('DOMContentLoaded', async () => {
    const token = localStorage.getItem('authToken');
    if (token) {
        try {
            const response = await fetchWithAuth('/protected', { method: 'GET' });
            if (response.ok) {
                updateUserUI();
            } else {
                alert('Sessão expirada. Faça login novamente.');
                localStorage.removeItem('authToken');
                updateUserUI();
            }
        } catch (error) {
            console.error('Erro ao verificar o token:', error);
        }
    } else {
        updateUserUI();
    }
});

async function loadUserPlanning() {
    // Verifica se o usuário está logado e possui um token JWT
    const token = localStorage.getItem('authToken');
    if (!token) {
        alert('Você precisa estar logado para carregar o planejamento.');
        return;
    }

    showLoader('Carregando planejamento...');
    try {
        const response = await fetchWithAuth('/get-planning', {
            method: 'GET'
        });

        const data = await response.json();
        hideLoader();

        if (response.ok) {
            // Preenche os campos do formulário com os dados retornados do backend
            document.getElementById('daysOption').value = data.days_option;
            document.getElementById('days').value = data.days;
            document.getElementById('bankroll').value = data.bankroll;
            document.getElementById('targetProfit').value = data.target_profit;

            // Chama a função de atualização da meta diária após preencher os dados
            updateDailyTarget();
        } else {
            // Se não houver dados de planejamento, permite ao usuário preencher o formulário
            alert('Nenhum planejamento encontrado. Preencha o formulário abaixo para salvar um novo planejamento.');
        }
    } catch (error) {
        console.error('Erro ao carregar o planejamento de apostas:', error);
        hideLoader();
    }
}


document.getElementById('submitPlanningForm').addEventListener('click', async (e) => {
    e.preventDefault(); // Impede o envio tradicional do formulário

    // Coleta os valores dos campos do formulário
    const daysOption = document.getElementById('daysOption').value;
    const days = document.getElementById('days').value;
    const bankroll = document.getElementById('bankroll').value;
    const targetProfit = document.getElementById('targetProfit').value;

    // Recupera o token JWT do localStorage
    let token = localStorage.getItem('authToken');
    if (!token) {
        alert("Você precisa estar logado para salvar o planejamento!");
        return;
    }

    showLoader('Salvando planejamento...');
    try {
        const response = await fetchWithAuth('/save-planning', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}` // Inclui o token no cabeçalho
            },
            body: JSON.stringify({
                daysOption,
                days,
                bankroll,
                targetProfit
            })
        });

        const data = await response.json();
        hideLoader();

        if (response.ok) {
            alert('Planejamento de apostas salvo com sucesso!');
        } else {
            alert(data.message || 'Erro ao salvar o planejamento');
        }
    } catch (error) {
        console.error('Erro ao enviar dados para o servidor:', error);
        hideLoader();
    }
});
