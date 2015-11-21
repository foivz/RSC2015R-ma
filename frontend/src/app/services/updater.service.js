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
      return Promise.resolve(this.parseGameData(this.mock.getData()));
    }
    return this.$http.get(this.config.apiUrl + '/games/' + this.id).then((data) => {
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

export default UpdaterService;
