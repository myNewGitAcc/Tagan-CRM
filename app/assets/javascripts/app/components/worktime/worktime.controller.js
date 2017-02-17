'use strict';

function worktimeController($rootScope, worktimeFactory, $scope, users, $http, $interval) {
    worktimeFactory.stopCalculation();
    
    this.hoursWorked = "XX часов XX минут XX секунд";
    this.remainsWork = "XX часов XX минут XX секунд";

    users.getProfile().then( function(response)  {
      this.userStatus = response.data.data.status;
      this.btn = true;

      worktimeFactory.checkRecord(response.data.data.id).then(function(response){
        if(this.userStatus=="online"){
          wrapperCalculation(response);
        }else{
          this.hoursWorked = worktimeFactory.desintegration(response.data.data.labor_hours);
          this.remainsWork = worktimeFactory.desintegration((8*60*60*1000)-response.data.data.labor_hours);
        }
      }, function(){
        this.hoursWorked="0 часов";
        this.remainsWork="8 часов";
      });

    });


    var chngUserStatus = function(status) {
      users.userStatusUpdate($scope.currentUserId, status=="offline"?0:status=="online"?1:2);
      this.userStatus = status;
    }

    var changingTimes = function(workedMs, becameOnline) {
      var workedTime = workedMs + (new Date() - Date.parse(becameOnline));
      this.hoursWorked =  worktimeFactory.desintegration(workedTime);

      var remainTime = new Date(8*60*60*1000) - worktimeFactory.msRounding(workedTime);
      if(remainTime>0)
        this.remainsWork = worktimeFactory.desintegration(remainTime);
      else
        this.remainsWork = "Дома ждут!";
    }

    var wrapperCalculation = function(response)  {
        worktimeFactory.runCalculation(changingTimes,response.data.data.labor_hours, response.data.data.status_change_date); 
    }

    var timeStartAtFirst = function(response) {
      worktimeFactory.createRecord($scope.currentUserId).then(wrapperCalculation);
    }

    var timeStartAtNext = function(response){
      worktimeFactory.updateRecordAtStartOrResume($scope.currentUserId).then(wrapperCalculation);
    }

    var timeStart = function() {
      worktimeFactory.checkRecord($scope.currentUserId).then(timeStartAtNext, timeStartAtFirst);
    }

    var timePauseOrAway = function() {
      if(this.userStatus=="online"){
        worktimeFactory.stopCalculation();
        worktimeFactory.checkRecord($scope.currentUserId).then(function(response){
          var ms = response.data.data.labor_hours + worktimeFactory.msRounding(new Date() - Date.parse(response.data.data.status_change_date));
          worktimeFactory.updateRecordAtPauseOrAway($scope.currentUserId, ms);
        });
      }
    }

    var timeResume =function(){
      worktimeFactory.checkRecord($scope.currentUserId).then(timeStartAtNext);
    }

    this.pause = function() {
      if(this.userStatus == "online"){
        timePauseOrAway();
        chngUserStatus("away");
      }
      else{
        timeResume();
        chngUserStatus("online");
      }
    }
    this.moveAway = function() {
      timePauseOrAway();
      chngUserStatus("offline");
    }
    this.startTime = function() {
      timeStart();
      chngUserStatus("online");
    }
}

worktimeController.$inject = ['$rootScope', 'worktimeFactory', '$scope', 'users', '$http', '$interval'];

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);