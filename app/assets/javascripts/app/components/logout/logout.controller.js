'use strict';

class LogoutController {
  constructor($window) {
    this.logout = ()=>{
      this.content = 'Do you want logout?';
      this.showPopUpDialog = true;
    }
   
    this.toManagment = ()=>{
      console.log('here')
      $window.location.href='/managment/inventories'
    }

    this.cancel = ()=> {
      this.showPopUpDialog = false;
    }

    this.close = ()=> {
      this.showPopUpDialog = false;
    }
  }

}


LogoutController.$inject = [ '$window'];
angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);