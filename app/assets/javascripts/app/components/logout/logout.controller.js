'use strict';

class LogoutController {
  constructor(LogoutFactory, $window) {
    this.logout = function (){
      this.content = 'Do you logout?';
      this.showPopUpDialog = true;
    }

    this.cancel = function() {
      this.showPopUpDialog = false;
    }

    this.close = function() {
      LogoutFactory.logout().then(function (response) {
          console.log(response.data);
          $window.location.reload();
        });
      this.showPopUpDialog = false;
    }
  }

}

angular.module('ngSpaApp')
  .controller('LogoutController', LogoutController);