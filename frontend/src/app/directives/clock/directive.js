class ClockController {
  constructor(moment) {
    'ngInject';

    // "this.creation" is avaible by directive option "bindToController: true"
    this.relativeDate = moment(this.startDate).fromNow();
    debugger;
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
