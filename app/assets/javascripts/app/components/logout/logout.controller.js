'use strict';

function LogoutController($scope){
  this.showPopUpDialog = false;

  this.logout = function(){
    this.content = 'Do you want logout?';
    this.showPopUpDialog = true;
  }

  this.cancel = function() {
    this.showPopUpDialog = false;
  }

  this.close = function() {
    this.showPopUpDialog = false;
  }
}


LogoutController.$inject = ['$scope'];
angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);