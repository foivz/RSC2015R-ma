class UpdaterService {
  constructor($http, configService) {
    'ngInject';
    this.config = configService.getData();
    this.$http = $http;
  }

  setId(id) {
    this.id = id;
  }

  startUpdates(cb, ctx) {
    this.iId = setInterval(() => {
      this.getGameData().then((data) => {
        cb.call(ctx, data);
      });
    }, this.config.updateTime);
  }

  stopUpdates() {
    clearInterval(this.iId);
  }

  getGameData() {
    if (this.config.mock === true) {
      var game = {
        field: {
          center: {
            latitude: 51.219053,
            longitude: 4.404418
          },
          zoom: 20
        },
        scoreA: Math.random(),
        scoreB: Math.random(),
        players: [
          {
            id: 1,
            position: {
              latitude: 51.219053 + (Math.random() / 10000),
              longitude: 4.404418 + (Math.random() / 10000)
            },
            team: 1
          },
          {
            id: 2,
            position: {
              latitude: 51.219053 + (Math.random() / 10000),
              longitude: 4.404518 + (Math.random() / 10000)
            },
            team: 2
          }
        ]
      };

      return Promise.resolve(game);
    }
    return this.$http.get(this.config.apiUrl + '/games/' + this.id).then((data) => {
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

export default UpdaterService;
