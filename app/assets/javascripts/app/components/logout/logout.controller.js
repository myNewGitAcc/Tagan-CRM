'use strict';

class LogoutController {
  constructor() {
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


LogoutController.$inject = [];
angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);