'use strict';

class worktimeController {
    constructor() {
        this.hoursWorked = 0;
        this.remainsWork = 0;
    }

}

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);