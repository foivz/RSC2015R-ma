class GamesController {
  constructor(gamesService, mainService, $state) {
    'ngInject';
    this.$state = $state;
    this.gamesService = gamesService;
    this.mainService = mainService;

    gamesService.getGames().then((data) => {
      this.games = data;
      this.games.forEach((game) => {
        var latitude = (parseFloat(game.field.latitude_nw) + parseFloat(game.field.latitude_se)) / 2;
        var longitude = (parseFloat(game.field.longitude_nw) + parseFloat(game.field.longitude_se)) / 2;

        game.map = {
          center: {
            latitude: latitude,
            longitude: longitude
          },
          zoom: 19,
          options: {
            disableDefaultUI: true,
            draggable: false,
            zoomControl: false,
            scrollwheel: false
          }
        };

        let teamA = game.team_a;
        let teamB = game.team_b;

        game.team = {
          A: {
            name: teamA.name,
            count: teamA.count,
            position: {
              latitude: parseFloat(teamA.latitude),
              longitude: parseFloat(teamA.longitude)
            },
            score: teamA.score
          },
          B: {
            name: teamB.name,
            count: teamB.count,
            position: {
              latitude: parseFloat(teamB.latitude),
              longitude: parseFloat(teamB.longitude)
            },
            score: teamB.score
          }
        };
      });


    });
  }

  onGameClick(game) {
    this.gamesService.getGameData(game).then((data) => {
      this.mainService.setGame(data);
      this.$state.go('main');
    });
  }
}

export default GamesController;
