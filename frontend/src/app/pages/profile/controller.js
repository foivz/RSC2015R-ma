class ProfileController {
  constructor($state, profileService) {
    'ngInject';

    profileService.getUser($state.params.id).then((data) => {
      this.username = data.username;
      this.name = data.name;
      this.deaths = 0;
      this.wins = 0;
      this.loses = 0;
    });
  }
}

export default ProfileController;
