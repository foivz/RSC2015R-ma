class ConfigService {
  constructor() {
    'ngInject';

    this.data = {
      mock: true,
      
      apiUrl: 'http://37.139.4.107:3000/api'
    };
  }

  getData() {
    return this.data;
  }
}

export default ConfigService;
