async function fetchLiveGames() {
    try {
        const response = await fetch('/live-games');
        const data = await response.json();

        const gamesContainer = document.getElementById('games-container');
        gamesContainer.innerHTML = ''; // Limpa o conteúdo existente

        data.response.forEach(game => {
            const gameDiv = document.createElement('div');
            gameDiv.className = 'game';

            // Exibe informações do jogo
            gameDiv.innerHTML = `
                <h3>${game.teams.home.name} vs ${game.teams.away.name}</h3>
                <p>Placar: ${game.goals.home} - ${game.goals.away}</p>
                <button onclick="selectGame('${game.fixture.id}')">Acompanhar</button>
            `;

            gamesContainer.appendChild(gameDiv);
        });
    } catch (error) {
        console.error('Erro ao buscar jogos ao vivo:', error);
    }
}

function selectGame(gameId) {
    alert(`Você selecionou acompanhar o jogo de ID: ${gameId}`);
}

// Chama a função para buscar jogos ao vivo
fetchLiveGames();
