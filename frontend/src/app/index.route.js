function routerConfig($stateProvider, $urlRouterProvider) {
  'ngInject';
  $stateProvider
    .state('games', {
      url: '/',
      templateUrl: 'app/pages/games/template.html',
      controller: 'GamesController',
      controllerAs: 'games'
    })
    .state('main', {
      url: '/game',
      templateUrl: 'app/pages/main/template.html',
      controller: 'MainController',
      controllerAs: 'main'
    });

  $urlRouterProvider.otherwise('/');
}

export default routerConfig;
