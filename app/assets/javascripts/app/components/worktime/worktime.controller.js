'use strict';

class worktimeController {
  constructor(worktimeFactory, $scope, users) {
    this.hoursWorked = 0;
    this.remainsWork = 0;

    users.getProfile().then( (response) => {
      this.userStatus = response.data.data.status;
      this.btn = true;
    });

    let chngUserStatus = status => {
      users.userStatusUpdate($scope.currentUserId, status=="offline"?0:status=="online"?1:2);
      this.userStatus = status;
    }

    this.pause = () => {
      if(this.userStatus == "online")
        chngUserStatus("away");
      else
        chngUserStatus("online");
    }
    this.moveAway = () => {
      chngUserStatus("offline");
    }
    this.startTime = () => {
      chngUserStatus("online");
    }
  }

}

worktimeController.$inject = ['worktimeFactory', '$scope', 'users'];

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);