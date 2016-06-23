'use strict';

(function() {

  function worktimeFactoryService($http) {

    return {
      starTimer: function () {
        return ;
      },

      pauseTimer: function () {
        return ;
      },

      continueTimer: function () {
        return ;
      }
    };
  }

  angular.module('ngSpaApp')
    .factory('worktimeFactory', worktimeFactoryService);
})();