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

// Função de Login
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('login-email').value;
    const password = document.getElementById('login-password').value;

    try {
        const response = await fetch('/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        const data = await response.json();

        if (response.ok) {
            authToken = data.token;
            localStorage.setItem('userName', data.username); // Salva o nome do usuário no localStorage
            updateUserUI(); // Atualiza a interface para exibir o nome e o botão de logout
            alert('Login realizado com sucesso!');
            displayBetHistory();
            loadUserPlanning();
        } else {
            alert(data.message);
        }
    } catch (error) {
        console.error('Erro no login:', error);
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
        const response = await fetch('/protected', {
            headers: { Authorization: `Bearer ${authToken}` }
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
    try {
        const response = await fetch('/get-bet-history', {
            headers: { Authorization: `Bearer ${authToken}` }
        });
        const data = await response.json();

        if (response.ok) {
            const historyTable = document.getElementById('historyTable');
            historyTable.innerHTML = ''; // Limpa a tabela antes de adicionar novas apostas

            data.bets.forEach(bet => {
                const profit = bet.outcome === 'Vencedor' ? (bet.bet_value * (parseFloat(bet.odds) - 1)).toFixed(2) : '0.00';

                // Criação de uma nova linha na tabela para cada aposta
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${new Date(bet.game_date).toLocaleString('pt-BR', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit'
                    })}</td>
                    <td>${bet.home_team} x ${bet.away_team}</td>
                    <td>${bet.bet_choice}</td>
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
    }
}

// Atualizar a interface ao carregar a página
document.addEventListener('DOMContentLoaded', () => {
    updateUserUI(); // Atualiza o estado do usuário na interface ao carregar a página
});
// Função para carregar o planejamento de apostas do usuário
async function loadUserPlanning() {
    // Verifica se o usuário está logado e possui um token JWT
    if (!authToken) {
        alert('Você precisa estar logado para carregar o planejamento.');
        return;
    }

    try {
        // Faz a requisição para a rota que retorna os dados do planejamento de apostas
        const response = await fetch('/get-planning', {
            headers: { Authorization: `Bearer ${authToken}` }
        });

        const data = await response.json();

        if (response.ok) {
            // Preenche os campos do formulário com os dados retornados do backend
            document.getElementById('daysOption').value = data.days_option;
            document.getElementById('days').value = data.days;
            document.getElementById('bankroll').value = data.bankroll;
            document.getElementById('targetProfit').value = data.target_profit;
        } else {
            // Se não houver dados de planejamento, permite ao usuário preencher o formulário
            alert('Nenhum planejamento encontrado. Preencha o formulário abaixo para salvar um novo planejamento.');
        }
    } catch (error) {
        console.error('Erro ao carregar o planejamento de apostas:', error);
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

    // Envia os dados para o servidor
    try {
        const response = await fetch('/save-planning', {
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

        if (response.status === 401 && data.message === 'Token expirado') {
            console.log("Token expirado. Atualizando token...");
            localStorage.setItem('authToken', data.newToken); // Atualiza o token no localStorage
            token = data.newToken; // Atualiza o token atual

            // Reenvia a requisição com o novo token
            const retryResponse = await fetch('/save-planning', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}` // Usa o novo token
                },
                body: JSON.stringify({
                    daysOption,
                    days,
                    bankroll,
                    targetProfit
                })
            });

            const retryData = await retryResponse.json();
            if (retryResponse.ok) {
                alert('Planejamento de apostas salvo com sucesso!');
            } else {
                alert(retryData.message || 'Erro ao salvar o planejamento');
            }
        } else if (response.ok) {
            alert('Planejamento de apostas salvo com sucesso!');
        } else {
            alert(data.message || 'Erro ao salvar o planejamento');
        }
    } catch (error) {
        console.error('Erro ao enviar dados para o servidor:', error);
    }
});


