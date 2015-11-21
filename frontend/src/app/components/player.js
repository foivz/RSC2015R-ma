import MapObject from './map-object';

class Player extends MapObject {
  constructor(id, position, team) {
    super(id, position);
    this.team = team;
    this.isEliminated = false;
  }

  getTeam() {
    return this.team;
  }

  eliminate() {
    this.isEliminated = true;
  }

  moveTo(position) {
    this.position = position;
  }
}

export default Player;
