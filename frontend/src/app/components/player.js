import MapObject from './map-object';

class Player extends MapObject {
  constructor(id, type, position, team, name) {
    super(id, type, position);
    this.setTeam(team);
    this.setName(name);
    this.isEliminated = false;
  }

  getTeam() {
    return this.team;
  }

  setTeam(team) {
    this.team = team;
  }

  getName() {
    return this.name;
  }

  setName(name) {
    this.name = name;
  }

  eliminate() {
    this.isEliminated = true;
  }

  moveTo(position) {
    this.position = position;
  }
}

export default Player;
