'use strict';

class NavbarController {
  constructor($location) {
      this.activePage = $location.path();
      this.setPage = (n)=> {
        this.activePage = n == 1 ? '/' : n== 2 ? '/employees' : '/worldtime';
      }
  }

}

NavbarController.$inject = ['$location'];

angular.module('ngSpaApp')
  .controller('NavbarController', NavbarController);
