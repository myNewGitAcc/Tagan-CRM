'use strict';

(function() {

  function employeesFactoryService() {
    return {
      filtered: (role, users)=> {
        return _.filter(users,
                        (user)=>{
                          return user.role == role;
                        });
      }
    };
  }
  angular.module('ngSpaApp')
    .factory('employeesFactory', employeesFactoryService);
})();