class ClockController {
  constructor($scope, moment) {
    'ngInject';

    this.elapsed = moment(Date.now()).unix() - moment(Date.parse(this.startDate)).unix();
    this.currentTime = parseInt(this.duration, 10) - this.elapsed;
    setInterval(() => {
      this.currentTime--;
      this.calculateTimes();
      if (!$scope.$$phase) {
        $scope.$apply();
      }
    }, 1000);
  }

  calculateTimes() {
    this.minutes = Math.floor(this.currentTime / 60);
    this.seconds = moment().seconds(this.currentTime % 60).format('ss');
  }
}

class ClockDirective {
  constructor() {
    'ngInject';

    let directive = {
      restrict: 'E',
      templateUrl: 'app/directives/clock/template.html',
      scope: {
        startDate: '=',
        duration: '='
      },
      controller: ClockController,
      controllerAs: 'clock',
      bindToController: true
    };

    return directive;
  }
}

export default ClockDirective;
