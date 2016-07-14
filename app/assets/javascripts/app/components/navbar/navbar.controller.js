'use strict';

class NavbarController {
  constructor($location) {
      this.activePage = $location.path();
      this.setPage = (event)=> {
        this.activePage = event.target.pathname;
      }
  }

}

NavbarController.$inject = ['$location'];

angular.module('ngSpaApp')
  .controller('NavbarController', NavbarController);
