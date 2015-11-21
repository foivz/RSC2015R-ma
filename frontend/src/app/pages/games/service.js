class GamesService {
  constructor($http, configService, mockService) {
    'ngInject';
    this.config = configService.getData();
    this.mock = mockService;
    this.$http = $http;
  }

  getGames() {
    if (this.config.mock === true) {
      var games = [this.mock.getData().game];
      return Promise.resolve(games);
    }
    return this.$http.get(this.config.apiUrl + '/games').then((data) => {
      this.parseGamesData(data);
    }).catch((e) => {
      throw new Error(e);
    });
  }

  parseGamesData(data) {
    this.data = data.data.games;
    return this.data;
  }

  getGameData(g) {
    if (this.config.mock === true) {
      return Promise.resolve(this.parseGameData(this.mock.getData()));
    }

    return this.$http.get(this.config.apiUrl + '/games/' + g.id).then((data) => {
      this.parseGameData(data);
    }).catch((e) => {
      throw new Error(e);
    });
  }

  parseGameData(data) {
    this.data = data.game;
    return this.data;
  }
}

export default GamesService;
