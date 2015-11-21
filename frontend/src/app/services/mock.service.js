class MockService {
  constructor() {
    'ngInject';

    this.data = {
      game: {
        id: 1,
        startDate: '1448126151258',
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
          latitudeNw: 46.307795,
          longitudeNw: 16.337911,
          latitudeSe: 46.307243,
          longitudeSe: 16.338671,
          occupied: true
        },
        teamA: {
          id: 1,
          name: 'A',
          count: 2,
          latitude: 46.307795,
          longitude: 16.337911,
          score: 0,
          players: [
            {
              id: 1,
              name: 'Azzaro Mujić',
              ready: false,
              latitude: 46.307795 + Math.random() / 10000,
              longitude: 16.337911 + Math.random() / 10000,
              alive: true
            },
            {
              id: 2,
              name: 'Ivan Škoro',
              ready: true,
              latitude: 46.307795 + Math.random() / 10000,
              longitude: 16.337911 + Math.random() / 10000,
              alive: false
            }
          ]
        },
        teamB: {
          id: 2,
          name: 'B',
          count: 2,
          latitude: 46.307243,
          longitude: 16.338671,
          score: 1,
          players: [
            {
              id: 3,
              name: 'Gabrijel Mrgan',
              ready: false,
              latitude: 46.307243 + Math.random() / 10000,
              longitude: 16.338671 + Math.random() / 10000,
              alive: false
            },
            {
              id: 4,
              name: 'Dinko Ostrečki',
              ready: true,
              latitude: 46.307243 + Math.random() / 10000,
              longitude: 16.338671 + Math.random() / 10000,
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
