class MapObject {
  constructor(id, position) {
    this.id = id;
    this.position = position;
  }

  getPosition() {
    return this.position;
  }

  setPosition(position) {
    this.position = position;
  }
}

export default MapObject;
