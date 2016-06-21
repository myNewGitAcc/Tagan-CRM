'use strict';

angular.module('ngSpaApp')
  .directive('logOut', () => ({
    templateUrl: 'assets/app/components/logout/logout.html',
    restrict: 'E',
    controller: 'LogoutController',
    controllerAs: 'log'
  }));