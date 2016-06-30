'use strict';

angular.module('ngSpaApp')
  .directive('logOut', () => ({
    templateUrl: 'logout/logout.html',
    restrict: 'E',
    controller: 'LogoutController',
    controllerAs: 'log'
  }));