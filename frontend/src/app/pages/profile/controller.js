class ProfileController {
  constructor($state, profileService) {
    'ngInject';

    profileService.getUser($state.params.id).then((data) => {
      this.username = data.username;
      this.name = data.name;

      if (data.statistics) {
        this.deaths = data.statistics.death_count;
        this.wins = data.statistics.win_count;
        this.loses = data.statistics.loss_count;
        this.minDuration = data.statistics.min_duration;
        this.maxDuration = data.statistics.max_duration;
        this.avgDuration = data.statistics.avg_duration;
        this.minDuration = Math.floor(this.minDuration / 60) + ':' + moment().seconds(this.minDuration % 60).format('ss');
        this.maxDuration = Math.floor(this.maxDuration / 60) + ':' + moment().seconds(this.maxDuration % 60).format('ss');
        this.avgDuration = Math.floor(this.avgDuration / 60) + ':' + moment().seconds(this.avgDuration % 60).format('ss');
      } else {
        this.deaths = 0;
        this.wins = 0;
        this.loses = 0;
        this.minDuration = 'Unknown';
        this.maxDuration = 'Unknown';
        this.avgDuration = 'Unknown';
      }
    });
  }
}

export default ProfileController;
