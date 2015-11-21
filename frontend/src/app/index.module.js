/* global malarkey:false, toastr:false, moment:false */
import config from './index.config';

import routerConfig from './index.route';

import runBlock from './index.run';

import ConfigService from './services/config.service';

import MainService from './pages/main/service';
import GamesService from './pages/games/service';

import MainController from './pages/main/controller';
import GamesController from './pages/games/controller';

// import GithubContributorService from '../app/components/githubContributor/githubContributor.service';
// import WebDevTecService from '../app/components/webDevTec/webDevTec.service';
// import NavbarDirective from '../app/components/navbar/navbar.directive';
// import MalarkeyDirective from '../app/components/malarkey/malarkey.directive';

angular.module('testGen', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ui.router', 'uiGmapgoogle-maps', 'ngLodash'])
  .constant('malarkey', malarkey)
  .config(config)
  .config(function(uiGmapGoogleMapApiProvider) {
    uiGmapGoogleMapApiProvider.configure({
      key: 'AIzaSyB5azgSZgYpffmqAMRf3Z4fx2V5XWh3-4k',
      libraries: 'weather,geometry,visualization,places'
    });
  })

  .config(routerConfig)

  .run(runBlock)
  .service('configService', ConfigService)
  .service('mainService', MainService)
  .service('gamesService', GamesService)
  .controller('MainController', MainController)
  .controller('GamesController', GamesController);

  // .service('githubContributor', GithubContributorService)
  // .service('webDevTec', WebDevTecService)
  // .directive('acmeNavbar', () => new NavbarDirective())
  // .directive('acmeMalarkey', () => new MalarkeyDirective(malarkey));
