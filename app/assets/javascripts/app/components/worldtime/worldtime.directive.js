'use strict';

angular.module('ngSpaApp')
  .directive('scroll', () => ({
    restrict: 'A',
    controller: 'worldtimeController',
    controllerAs: 'wtCtrl'
  }));