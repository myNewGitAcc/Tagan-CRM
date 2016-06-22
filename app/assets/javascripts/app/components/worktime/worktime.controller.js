'use strict';

class worktimeController {
    constructor(worktimeFactory) {
        this.hoursWorked = 0;
        this.remainsWork = 0;
        this.onlineUser = false;
        this.buttonPause = 'Pause';
        this.buttonContinue = false;

        this.pause = function (){
            this.buttonContinue = !this.buttonContinue;
            if (this.buttonContinue) {
                this.buttonPause = 'Continue'; 
                worktimeFactory.pauseTimer();
            }
            else {
                this.buttonPause = 'Pause';  
                worktimeFactory.continueTimer();
            }
            
        }

        this.moveAway = function (){
            this.onlineUser = false;
        }

        this.startTime = function (){
            this.onlineUser = true;
            worktimeFactory.starTimer();
        }
    }

}

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);