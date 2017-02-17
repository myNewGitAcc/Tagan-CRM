'use strict';

angular.module('ngSpaApp')
  .directive('navbar', function() {
      return {
  templateUrl: 'navbar/navbar.html',
  restrict: 'E',
  controller: 'NavbarController',
  controllerAs: 'nav'
};});