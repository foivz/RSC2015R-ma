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
    var latitude = (this.game.field.latitude_nw + this.game.field.latitude_se) / 2;
    var longitude = (this.game.field.longitude_nw + this.game.field.longitude_se) / 2;

    this.map = {
      center: {
        latitude: latitude,
        longitude: longitude
      },
      zoom: 19,
      options: {
        disableDefaultUI: true,
        draggable: false,
        zoomControl: false
      }
    };

    this.gmap.then((maps) => {
      setTimeout(() => {
        var map = this.map.getGMap();
        this.fieldBounds = new maps.LatLngBounds({
          lat: this.game.field.latitude_nw,
          lng: this.game.field.longitude_nw
        }, {
          lat: this.game.field.latitude_se,
          lng: this.game.field.longitude_se
        });
        map.fitBounds(this.fieldBounds);
      }, 300);
    });
  }

  setAllMarkers() {
    this.markers = [];
    this.markers = this.markers.concat(this.players);
  }

  setTeamsAndPlayers() {
    this.players = [];
    let teamA = this.game.team_a;
    let teamB = this.game.team_b;
    let teamAPlayers = teamA.players.map((el) => {
      var x = new Player(el.id, {
        latitude: el.latitude,
        longitude: el.longitude
      }, teamA.name, el.name);

      if (!el.alive) {
        x.eliminate();
      }

      this.players.push(x);
      return x;
    });
    let teamBPlayers = teamB.players.map((el) => {
      var x = new Player(el.id, {
        latitude: el.latitude,
        longitude: el.longitude
      }, teamB.name, el.name);

      if (!el.alive) {
        x.eliminate();
      }

      this.players.push(x);
      return x;
    });

    this.team = {
      A: {
        name: teamA.name,
        count: teamA.count,
        position: {
          latitude: teamA.latitude,
          longitude: teamA.longitude
        },
        players: teamAPlayers,
        score: teamA.score
      },
      B: {
        name: teamB.name,
        count: teamB.count,
        position: {
          latitude: teamB.latitude,
          longitude: teamB.longitude
        },
        players: teamBPlayers,
        score: teamB.score
      }
    };

    this.updateAlive();
  }

  update(data) {
    this.updatePlayers(data);
    this.updateScores(data);

    this.refreshMap();
  }

  updatePlayers(data) {
    this.players.forEach((el) => {
      data.team_a.players.forEach((p) => {
        if (el.id === p.id) {
          el.moveTo({
            latitude: p.latitude,
            longitude: p.longitude
          });
        }
      });
      data.team_b.players.forEach((p) => {
        if (el.id === p.id) {
          el.moveTo({
            latitude: p.latitude,
            longitude: p.longitude
          });
        }
      });
    });

    this.updateAlive();
  }

  updateAlive() {
    this.team.A.alive = 0;
    this.team.A.players.forEach((el) => {
      if (!el.isEliminated) {
        this.team.A.alive++;
      }
    });

    this.team.B.alive = 0;
    this.team.B.players.forEach((el) => {
      if (!el.isEliminated) {
        this.team.B.alive++;
      }
    });
  }

  updateScores(data) {
    this.team.A.score = data.team_a.score;
    this.team.B.score = data.team_b.score;
  }

  refreshMap() {
    if (this.map.refresh) {
      this.map.refresh();
    }
    this.$scope.$apply();
  }
}

export default MainController;
