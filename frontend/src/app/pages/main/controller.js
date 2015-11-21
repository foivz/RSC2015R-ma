import Player from '../../components/player';

class MainController {
  constructor($scope, mainService, uiGmapGoogleMapApi, updaterService) {
    'ngInject';
    this.$scope = $scope;
    this.game = mainService.getGame();
    this.updaterService = updaterService;
    this.map = this.game.field;
    this.setAllMarkers();

    this.updaterService.startUpdates(this.update, this);

    uiGmapGoogleMapApi.then(() => {});
  }

  setAllMarkers() {
    this.markers = [];

    this.players = this.game.players.map((el) => {
      return new Player(el.id, el.position, el.team);
    });

    this.markers = this.markers.concat(this.players);
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
    this.teamScores = {
      left: a,
      right: b
    };
  }

  refreshMap() {
    this.map.refresh();
    this.$scope.$apply();
  }
}

export default MainController;
