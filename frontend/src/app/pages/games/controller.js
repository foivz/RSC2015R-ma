class GamesController {
  constructor(gamesService, mainService, $state) {
    'ngInject';
    this.$state = $state;
    this.gamesService = gamesService;
    this.mainService = mainService;

    gamesService.getGames().then((data) => {
      this.games = data;
    });
  }

  onGameClick(game) {
    this.gamesService.getGameData(game).then((data) => {
      this.mainService.setGame(data);
      this.$state.go('main');
    });
  }
}

export default GamesController;
