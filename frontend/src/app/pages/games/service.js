class GamesService {
  constructor($http, configService) {
    'ngInject';
    this.config = configService.getData();
    this.$http = $http;
  }

  getGames() {
    if (this.config.mock === true) {
      var games = [
        {
          name: 'testis',
          id: 1
        },
        {
          name: 'testis2',
          id: 2
        },
        {
          name: 'testis3',
          id: 3
        },
        {
          name: 'testis4',
          id: 4
        }
      ];
      return Promise.resolve(games);
    }
    return this.$http.get(this.config.apiUrl + '/games/all').then((data) => {
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
      var game = {
        field: {
          center: {
            latitude: 51.219053,
            longitude: 4.404418
          },
          zoom: 20
        },
        players: [
          {
            id: 1,
            position: {
              latitude: 51.219053,
              longitude: 4.404418
            },
            team: 1
          },
          {
            id: 2,
            position: {
              latitude: 51.219053,
              longitude: 4.404518
            },
            team: 2
          }
        ]
      };

      return Promise.resolve(game);
    }
    return this.$http.get(this.config.apiUrl + '/games/' + g.id).then((data) => {
      this.parseGameData(data);
    }).catch((e) => {
      throw new Error(e);
    });
  }

  parseGameData(data) {
    this.data = data.data.game;
    return this.data;
  }
}

export default GamesService;
