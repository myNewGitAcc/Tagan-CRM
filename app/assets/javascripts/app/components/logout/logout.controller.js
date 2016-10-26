'use strict';

function LogoutController($scope){
  this.showPopUpDialog = false;

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


LogoutController.$inject = ['$scope'];
angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);