class ConfigService {
  constructor() {
    'ngInject';

    this.data = {
      mock: false,

      updateTime: 1000,
      apiUrl: 'http://37.139.4.107:3000/api'
    };
  }

  getData() {
    return this.data;
  }
}

export default ConfigService;
