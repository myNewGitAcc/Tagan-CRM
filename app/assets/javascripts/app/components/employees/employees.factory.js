'use strict';

(function() {

  function employeesFactoryService() {
    return {
      filtered: (payload, users)=> {
        users.forEach((user)=>{
          //user.status = user.id == payload.id ? payload.status: user.status;
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