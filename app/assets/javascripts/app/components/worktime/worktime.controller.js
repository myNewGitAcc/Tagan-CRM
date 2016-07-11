'use strict';

class worktimeController {
  constructor(worktimeFactory, $scope, users) {
    this.hoursWorked = 0;
    this.remainsWork = 0;
    this.onlineUser = null;

    users.getProfile().then( (response) => {
      this.onlineUser = response.data.data.status;
      this.buttonPause = this.onlineUser == 'away' ? 'Continue' : 'Pause';
      this.btn = true;
    });

    this.pause = ()=> {
      if (this.buttonPause == 'Pause') {
        this.buttonPause = 'Continue';
        users.userStatusUpdate($scope.currentUserId, 2);
      }
      else {
        this.buttonPause = 'Pause';
        users.userStatusUpdate($scope.currentUserId, 1);
      }
    }

    this.moveAway = ()=> {
      users.userStatusUpdate($scope.currentUserId, 0);
      this.buttonPause = 'Pause';
      this.onlineUser = 'offline';
    }

    this.startTime = ()=> {
      users.userStatusUpdate($scope.currentUserId, 1);
      this.onlineUser = 'online';
    }
  }

}

worktimeController.$inject = ['worktimeFactory', '$scope', 'users'];

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);