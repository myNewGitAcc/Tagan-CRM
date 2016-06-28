'use strict';

(function() {

    function employeesFactoryService($http) {
      return {
        getUsers: ()=> {
          return $http.get('/api/v1/users/users');
          },
        filtered: (role_id, users)=> {

          return _.filter(users,
                          (user)=>{
                            return user.role_id == role_id;
                          });
        }
      };
        
        
    }

    angular.module('ngSpaApp')
        .factory('employeesFactory', employeesFactoryService);
})();