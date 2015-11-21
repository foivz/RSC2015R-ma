class MainService {
  constructor($http, configService) {
    'ngInject';
    this.config = configService.getData();
    this.$http = $http;
  }

  setGame(game) {
    this.game = game;
  }

  getGame() {
    return this.game;
  }
}

export default MainService;
