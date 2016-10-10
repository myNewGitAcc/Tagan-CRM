'use strict';

class LogoutController {
  constructor($scope) {
    this.showPopUpDialog = false;

    //console.log("шоупопапдиалог: " + this.showPopUpDialog);

    this.logout = ()=>{
      this.content = 'Do you want logout?';
      this.showPopUpDialog = true;
    }

    this.cancel = ()=> {
      this.showPopUpDialog = false;
    }

    this.close = ()=> {
      this.showPopUpDialog = false;
    }
  }

}


//LogoutController.$inject = [];
angular.module('ngSpaApp')
  .controller('LogoutController', ['$scope', function($scope) {return new LogoutController($scope);}]);