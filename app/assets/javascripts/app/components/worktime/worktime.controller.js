'use strict';

function worktimeController($rootScope, worktimeFactory, $scope, users, $http, $interval) {
    worktimeFactory.stopCalculation();
    
    this.hoursWorked = "XX часов XX минут XX секунд";
    this.remainsWork = "XX часов XX минут XX секунд";

    users.getProfile().then( (response) => {
      this.userStatus = response.data.data.status;
      this.btn = true;

      worktimeFactory.checkRecord(response.data.data.id).then((response)=>{
        if(this.userStatus=="online"){
          wrapperCalculation(response);
        }else{
          this.hoursWorked = worktimeFactory.desintegration(response.data.data.labor_hours);
          this.remainsWork = worktimeFactory.desintegration((8*60*60*1000)-response.data.data.labor_hours);
        }
      }, ()=>{
        this.hoursWorked="0 часов";
        this.remainsWork="8 часов";
      });

    });


    let chngUserStatus = status => {
      users.userStatusUpdate($scope.currentUserId, this.hoursWorked, status=="offline"?0:status=="online"?1:2);
      this.userStatus = status;
    }

    let changingTimes = (workedMs, becameOnline)=> {
      var workedTime = workedMs + (new Date() - Date.parse(becameOnline));
      this.hoursWorked =  worktimeFactory.desintegration(workedTime);
      var hours = worktimeFactory.getUTCHours(workedTime);
      users.userHoursUpdate($scope.currentUserId, hours, this.userStatus);

      var remainTime = new Date(8*60*60*1000) - worktimeFactory.msRounding(workedTime);
      if(remainTime>0)
        this.remainsWork = worktimeFactory.desintegration(remainTime);
      else
        this.remainsWork = "Дома ждут!";
    }

    let wrapperCalculation = response => {
        worktimeFactory.runCalculation(changingTimes,response.data.data.labor_hours, response.data.data.status_change_date); 
    }

    let timeStartAtFirst = response => {
      worktimeFactory.createRecord($scope.currentUserId).then(wrapperCalculation);
    }

    let timeStartAtNext = response => {
      worktimeFactory.updateRecordAtStartOrResume($scope.currentUserId).then(wrapperCalculation);
    }

    let timeStart = () => {
      worktimeFactory.checkRecord($scope.currentUserId).then(timeStartAtNext, timeStartAtFirst);
    }

    let timePauseOrAway = () => {
      if(this.userStatus=="online"){
        worktimeFactory.stopCalculation();
        worktimeFactory.checkRecord($scope.currentUserId).then((response)=>{
          var ms = response.data.data.labor_hours + worktimeFactory.msRounding(new Date() - Date.parse(response.data.data.status_change_date));
          worktimeFactory.updateRecordAtPauseOrAway($scope.currentUserId, ms);
        });
      }
    }

    let timeResume =()=>{
      worktimeFactory.checkRecord($scope.currentUserId).then(timeStartAtNext);
    }

    this.pause = () => {
      if(this.userStatus == "online"){
        timePauseOrAway();
        chngUserStatus("away");
      }
      else{
        timeResume();
        chngUserStatus("online");
      }
    }
    this.moveAway = () => {
      timePauseOrAway();
      chngUserStatus("offline");
    }
    this.startTime = () => {
      timeStart();
      chngUserStatus("online");
    }
}

worktimeController.$inject = ['$rootScope', 'worktimeFactory', '$scope', 'users', '$http', '$interval'];

angular.module('ngSpaApp')
  .controller('worktimeController', worktimeController);