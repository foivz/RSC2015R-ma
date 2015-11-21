import Player from '../../components/player';

class MainController {
  constructor($scope, mainService, uiGmapGoogleMapApi, updaterService) {
    'ngInject';
    this.$scope = $scope;
    this.game = mainService.getGame();
    this.updaterService = updaterService;
    this.gmap = uiGmapGoogleMapApi;

    this.setMapInformation();
    this.setTeamsAndPlayers();
    this.setAllMarkers();

    this.updaterService.startUpdates(this.update, this);
  }

  setMapInformation() {
    var latitude = (this.game.field.latitudeNw + this.game.field.latitudeSe) / 2;
    var longitude = (this.game.field.longitudeNw + this.game.field.longitudeSe) / 2;

    this.map = {
      center: {
        latitude: latitude,
        longitude: longitude
      },
      zoom: 19
    };

    this.gmap.then((maps) => {
      setTimeout(() => {
        var map = this.map.getGMap();
        var bounds = new maps.LatLngBounds({
          lat: this.game.field.latitudeNw,
          lng: this.game.field.longitudeNw
        }, {
          lat: this.game.field.latitudeSe,
          lng: this.game.field.longitudeSe
        });
        map.fitBounds(bounds);
      }, 300);
    });
  }

  setAllMarkers() {
    this.markers = [];
    this.markers = this.markers.concat(this.players);
  }

  setTeamsAndPlayers() {
    this.players = [];
    let teamA = this.game.teamA;
    let teamB = this.game.teamB;
    let teamAPlayers = this.game.teamA.players.map((el) => {
      var x = new Player(el.id, {
        latitude: el.latitude,
        longitude: el.longitude
      }, teamA.name, el.name);
      this.players.push(x);
      return x;
    });
    let teamBPlayers = this.game.teamB.players.map((el) => {
      var x = new Player(el.id, {
        latitude: el.latitude,
        longitude: el.longitude
      }, teamB.name, el.name);
      this.players.push(x);
      return x;
    });

    this.team = {
      A: {
        position: {
          latitude: teamA.latitude,
          longitude: teamA.longitude
        },
        players: teamAPlayers,
        score: teamA.score
      },
      B: {
        position: {
          latitude: teamB.latitude,
          longitude: teamB.longitude
        },
        players: teamBPlayers,
        score: teamB.score
      }
    };
  }

  update(data) {
    this.updatePlayers(data);
    this.updateScores(data);

    //get new data
    this.refreshMap();
  }

  updatePlayers(data) {

    // players.forEach((el) => {
    //   this.players.filter((p) => {
    //     if (p.id === el.id) {
    //       p.setPosition(el.position);
    //     }
    //   });
    // });
  }

  updateScores(data) {
    this.team.A.score = data.teamA.score;
    this.team.B.score = data.teamB.score;
  }

  refreshMap() {
    this.map.refresh();
    this.$scope.$apply();
  }
}

export default MainController;
