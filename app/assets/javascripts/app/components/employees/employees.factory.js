'use strict';

(function() {

  function employeesFactoryService() {
    return {
      filtered: function(payload, users) {
        users.forEach(function(user){
          if (user.id == payload.id) {
            user.status = payload.status;
          }
        });
        return users;
      }
    };
  }
  angular.module('ngSpaApp')
    .factory('employeesFactory', employeesFactoryService);
})();