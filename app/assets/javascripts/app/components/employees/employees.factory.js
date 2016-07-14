'use strict';

(function() {

  function employeesFactoryService() {
    return {
      filtered: (payload, users)=> {
        users.forEach((user)=>{
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