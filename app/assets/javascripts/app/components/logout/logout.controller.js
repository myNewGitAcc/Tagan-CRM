'use strict';

class LogoutController {
  constructor() {
    this.logout = function (){
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

}

angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);