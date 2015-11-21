/* global malarkey:false, toastr:false, moment:false */
import config from './index.config';

import routerConfig from './index.route';

import runBlock from './index.run';

import ConfigService from './services/config.service';

import MainController from './pages/main/controller';

// import GithubContributorService from '../app/components/githubContributor/githubContributor.service';
// import WebDevTecService from '../app/components/webDevTec/webDevTec.service';
// import NavbarDirective from '../app/components/navbar/navbar.directive';
// import MalarkeyDirective from '../app/components/malarkey/malarkey.directive';

angular.module('testGen', ['ngAnimate', 'ngCookies', 'ngTouch', 'ngSanitize', 'ui.router'])
  .constant('malarkey', malarkey)
  .config(config)

  .config(routerConfig)

  .run(runBlock)
  .service('configService', ConfigService)
  .controller('MainController', MainController);

  // .service('githubContributor', GithubContributorService)
  // .service('webDevTec', WebDevTecService)
  // .directive('acmeNavbar', () => new NavbarDirective())
  // .directive('acmeMalarkey', () => new MalarkeyDirective(malarkey));
