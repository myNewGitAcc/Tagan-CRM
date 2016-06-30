'use strict';

(function() {

    function employeesFactoryService($http) {
      return {
        getUsers: ()=> {
          return $http.get('/api/v1/users/users');
          },
        filtered: (role, users)=> {

          return _.filter(users,
                          (user)=>{
                            return user.role == role;
                          });
        }
      };
        
        
    }
  employeesFactoryService.$inject = ['$http'];

    angular.module('ngSpaApp')
        .factory('employeesFactory', employeesFactoryService);
})();