'use strict';

(function() {

  function worktimeFactoryService($http) {

    return {

    };
  }
  worktimeFactoryService.$inject = ['$http'];

  angular.module('ngSpaApp')
    .factory('worktimeFactory', worktimeFactoryService);
})();
