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
    })
    .state('profile', {
      url: '/profile?id',
      templateUrl: 'app/pages/profile/template.html',
      controller: 'ProfileController',
      controllerAs: 'profile'
    });

  $urlRouterProvider.otherwise('/');
}

export default routerConfig;
