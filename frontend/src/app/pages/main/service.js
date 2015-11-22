class MainService {
  constructor($http, configService, updaterService) {
    'ngInject';
    this.config = configService.getData();
    this.updaterService = updaterService;
    this.$http = $http;
  }

  setGame(game) {
    this.game = game;
    this.updaterService.setId(game.id);
  }

  getGame() {
    return this.game;
  }
}

export default MainService;
