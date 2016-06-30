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
  worktimeFactoryService.$inject = ['$http'];

  angular.module('ngSpaApp')
    .factory('worktimeFactory', worktimeFactoryService);
})();