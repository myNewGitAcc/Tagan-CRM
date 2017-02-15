'use strict';

angular.module('ngSpaApp')
  .directive('logOut', function() {
      return {
    templateUrl: 'logout/logout.html',
    restrict: 'E',
    controller: 'LogoutController',
    controllerAs: 'log'
  };
  });