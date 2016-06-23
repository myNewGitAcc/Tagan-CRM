'use strict';

angular.module('ngSpaApp')
  .directive('navbar', () => ({
  templateUrl: 'assets/app/components/navbar/navbar.html',
  restrict: 'E',
  controller: 'NavbarController',
  controllerAs: 'nav'
}));