'use strict';

class worktimeController {
    constructor(worktimeFactory) {
        this.hoursWorked = 0;
        this.remainsWork = 0;
        this.onlineUser = false;
        this.buttonPause = 'Pause';

        this.pause = ()=> {
          if (this.buttonPause == 'Pause') {
            this.buttonPause = 'Continue';
            worktimeFactory.pauseTimer();
          }
          else {
            this.buttonPause = 'Pause';
            worktimeFactory.continueTimer();
          }
            
        }

        this.moveAway = ()=> {
          this.buttonPause = 'Pause';
          this.onlineUser = false;
        }

        this.startTime = ()=> {
            this.onlineUser = true;
            worktimeFactory.starTimer();
        }
    }

}

worktimeController.$inject = ['worktimeFactory'];

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);