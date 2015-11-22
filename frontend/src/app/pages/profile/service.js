class GamesService {
  constructor($http, configService, mockService) {
    'ngInject';
    this.config = configService.getData();
    this.mock = mockService;
    this.$http = $http;
  }

  getUser(id) {
    return this.$http.get(this.config.apiUrl + '/users/' + id).then((data) => {
      return data.data.user;
    }).catch((e) => {
      throw new Error(e);
    });
  }
}

export default GamesService;
