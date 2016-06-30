'use strict';

angular.module('ngSpaApp')
  .directive('navbar', () => ({
  templateUrl: 'navbar/navbar.html',
  restrict: 'E',
  controller: 'NavbarController',
  controllerAs: 'nav'
}));