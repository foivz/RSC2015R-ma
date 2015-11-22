import Player from '../../components/player';
import MapObject from '../../components/map-object';

class MainController {
  constructor($scope, mainService, uiGmapGoogleMapApi, updaterService) {
    'ngInject';
    this.$scope = $scope;
    this.game = mainService.getGame();
    this.updaterService = updaterService;
    this.gmap = uiGmapGoogleMapApi;

    this.setMapInformation();
    this.setTeamsAndPlayers();
    this.setOtherMarkerInfo();
    this.setAllMarkers();

    this.updaterService.startUpdates(this.update, this);
  }

  setMapInformation() {
    var latitude = (parseFloat(this.game.field.latitude_nw) + parseFloat(this.game.field.latitude_se)) / 2;
    var longitude = (parseFloat(this.game.field.longitude_nw) + parseFloat(this.game.field.longitude_se)) / 2;

    this.map = {
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

    this.gmap.then((maps) => {
      setTimeout(() => {
        var map = this.map.getGMap();
        this.fieldBounds = new maps.LatLngBounds({
          lat: parseFloat(this.game.field.latitude_nw),
          lng: parseFloat(this.game.field.longitude_nw)
        }, {
          lat: parseFloat(this.game.field.latitude_se),
          lng: parseFloat(this.game.field.longitude_se)
        });
        map.fitBounds(this.fieldBounds);
      }, 300);
    });
  }

  setAllMarkers() {
    this.markers = [];
    this.markers = this.markers.concat(this.players).concat(this.obstacles).concat(this.teamFlags);
  }

  setTeamsAndPlayers() {
    this.players = [];
    let teamA = this.game.team_a;
    let teamB = this.game.team_b;
    let teamAPlayers = teamA.players.map((el) => {
      var x = new Player(el.id, 'playerA', {
        latitude: parseFloat(el.latitude),
        longitude: parseFloat(el.longitude)
      }, teamA.name, el.name);

      if (!el.alive) {
        x.eliminate();
      }

      this.players.push(x);
      return x;
    });
    let teamBPlayers = teamB.players.map((el) => {
      var x = new Player(el.id, 'playerB', {
        latitude: parseFloat(el.latitude),
        longitude: parseFloat(el.longitude)
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
        count: teamA.total_count,
        position: {
          latitude: parseFloat(teamA.latitude),
          longitude: parseFloat(teamA.longitude)
        },
        players: teamAPlayers,
        score: teamA.score
      },
      B: {
        name: teamB.name,
        count: teamB.total_count,
        position: {
          latitude: parseFloat(teamB.latitude),
          longitude: parseFloat(teamB.longitude)
        },
        players: teamBPlayers,
        score: teamB.score
      }
    };

    this.updateAlive();
  }

  setOtherMarkerInfo() {
    this.obstacles = [];
    this.game.obstacles.forEach((el) => {
      this.obstacles.push(new MapObject(el.id, el.type, {
        latitude: parseFloat(el.latitude),
        longitude: parseFloat(el.longitude)
      }));
    });

    this.teamFlags = [
      new MapObject(this.game.team_a.id, 'startA', {latitude: parseFloat(this.game.team_a.latitude), longitude: parseFloat(this.game.team_a.longitude)}),
      new MapObject(this.game.team_b.id, 'startB', {latitude: parseFloat(this.game.team_b.latitude), longitude: parseFloat(this.game.team_b.longitude)})
    ];
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
            latitude: parseFloat(p.latitude),
            longitude: parseFloat(p.longitude)
          });
        }
      });
      data.team_b.players.forEach((p) => {
        if (el.id === p.id) {
          el.moveTo({
            latitude: parseFloat(p.latitude),
            longitude: parseFloat(p.longitude)
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

    if (!this.$scope.$$phase) {
      this.$scope.$apply();
    }
  }
}

export default MainController;
