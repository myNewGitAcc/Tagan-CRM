'use strict';

(function() {

  function worktimeFactoryService($http) {

    return {
      starTimer: ()=> {
        return ;
      },

      pauseTimer: ()=> {
        return ;
      },

      continueTimer: ()=> {
        return ;
      }
    };
  }

  angular.module('ngSpaApp')
    .factory('worktimeFactory', worktimeFactoryService);
})();