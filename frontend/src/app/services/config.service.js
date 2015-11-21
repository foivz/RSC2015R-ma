class ConfigService {
  constructor() {
    'ngInject';

    this.$http = $http;
    this.data = {
      apiUrl: 'http://37.139.4.107:3000/api'
      
    };
  }

  getDat() {
    return this.data;
  }
}

export default ConfigService;
