class MapObject {
  constructor(id, type, position) {
    this.id = id;
    this.type = type;
    this.position = position;

    this.setIconByType();
  }

  getPosition() {
    return this.position;
  }

  setPosition(position) {
    this.position = position;
  }

  setIconByType() {
    this.icon = '/assets/images/pin_';
    if (this.type === 'obstacle') {
      this.icon += 'obstacle.png';
    }

    if (this.type === 'playerA') {
      this.icon += 'Aplayer.png';
    }

    if (this.type === 'playerB') {
      this.icon += 'Bplayer.png';
    }

    if (this.type === 'startA') {
      this.icon += 'astart.png';
    }

    if (this.type === 'startB') {
      this.icon += 'bstart.png';
    }

    if (this.type === 'flag') {
      this.icon += 'flag.png';
    }
  }
}

export default MapObject;
