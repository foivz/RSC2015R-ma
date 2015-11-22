class UpdaterService {
  constructor($http, configService, mockService) {
    'ngInject';
    this.config = configService.getData();
    this.$http = $http;
    this.mock = mockService;
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
      return Promise.resolve(this.parseGameData({
        data: this.mock.getData()
      }));
    }
    return this.$http.get(this.config.apiUrl + '/games/' + this.id).then((data) => {
      return this.parseGameData(data);
    }).catch((e) => {
      throw new Error(e);
    });
  }

  parseGameData(data) {
    this.data = data.data.game;

    // var baseLatA = 46.307795;
    // var baseLngA = 16.337911;
    // var baseLatB = 46.307243;
    // var baseLngB = 16.338671;
    //
    // this.data.team_a.players.forEach((el) => {
    //   el.latitude = baseLatA - Math.random() / 10000;
    //   el.longitude = baseLngA + Math.random() / 10000;
    // });
    // this.data.team_b.players.forEach((el) => {
    //   el.latitude = baseLatB + Math.random() / 10000;
    //   el.longitude = baseLngB - Math.random() / 10000;
    // });

    return this.data;
  }
}

export default UpdaterService;
