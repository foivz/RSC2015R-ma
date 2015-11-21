class MockService {
  constructor() {
    'ngInject';

    this.data = {
      game: {
        id: 1,
        type: 'CTF',
        duration: '3600',
        pin: '1234',
        obstacles: [
          {
            id: 1,
            latitude: 12,
            longitude: 12,
            type: 'Planks'
          },
          {
            id: 2,
            latitude: 12,
            longitude: 12,
            type: 'Flag'
          },
          {
            id: 3,
            latitude: 12,
            longitude: 12,
            type: 'Flag'
          }
        ],
        field: {
          id: 1,
          name: 'Field 1',
          latitudeNw: 12,
          longitudeNw: 12,
          latitudeSe: 12,
          longitudeSe: 12,
          occupied: true
        },
        teamA: {
          id: 1,
          name: 'A',
          count: 2,
          latitude: 12,
          longitude: 12,
          score: 0,
          players: [
            {
              id: 1,
              name: 'Azzaro Mujić',
              ready: false,
              latitude: 12,
              longitude: 12,
              alive: true
            },
            {
              id: 2,
              name: 'Ivan Škoro',
              ready: true,
              latitude: 12,
              longitude: 12,
              alive: false
            }
          ]
        },
        teamB: {
          id: 2,
          name: 'B',
          count: 2,
          latitude: 12,
          longitude: 12,
          score: 1,
          players: [
            {
              id: 3,
              name: 'Gabrijel Mrgan',
              ready: false,
              latitude: 12,
              longitude: 12,
              alive: false
            },
            {
              id: 4,
              name: 'Dinko Ostrečki',
              ready: true,
              latitude: 12,
              longitude: 12,
              alive: true
            }
          ]
        }
      }
    };
  }

  getData() {
    return this.data;
  }
}

export default MockService;
