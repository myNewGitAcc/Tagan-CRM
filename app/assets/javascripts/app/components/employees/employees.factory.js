'use strict';

(function() {

  function employeesFactoryService() {
    return {
      filtered: (payload, users)=> {
        var User =  _.filter(users,
                                (user)=>{
                                  return user.id == payload.id;
                                });
        User[0].status = payload.status;
        return _.extend(users, User);
      }
    };
  }
  angular.module('ngSpaApp')
    .factory('employeesFactory', employeesFactoryService);
})();