import Player from '../../components/player';

class MainController {
  constructor($scope, mainService, uiGmapGoogleMapApi, updaterService) {
    'ngInject';
    this.$scope = $scope;
    this.game = mainService.getGame();
    this.updaterService = updaterService;
    this.map = this.game.field;
    this.setTeams();
    this.setAllMarkers();

    this.updaterService.startUpdates(this.update, this);

    uiGmapGoogleMapApi.then(() => {});
  }

  setAllMarkers() {
    this.markers = [];

    this.players = this.game.players.map((el) => {
      var x = new Player(el.id, el.position, el.team);
      if (el.team === 1) {
        this.team.left.players.push(x);
      } else {
        this.team.right.players.push(x);
      }
      return x;
    });

    this.markers = this.markers.concat(this.players);
  }

  setTeams() {
    this.team = {
      left: {
        players: [],
        score: 0
      },
      right: {
        players: [],
        score: 0
      }
    };
  }

  update(data) {
    this.updatePlayers(data.players);
    this.updateScores(data.scoreA, data.scoreB);

    //get new data
    this.refreshMap();
  }

  updatePlayers(players) {
    players.forEach((el) => {
      this.players.filter((p) => {
        if (p.id === el.id) {
          p.setPosition(el.position);
        }
      });
    });
  }

  updateScores(a, b) {
    this.team.left.score = a;
    this.team.right.score = b;
  }

  refreshMap() {
    this.map.refresh();
    this.$scope.$apply();
  }
}

export default MainController;
