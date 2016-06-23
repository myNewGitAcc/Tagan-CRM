'use strict';

(function() {

    function employeesFactoryService($resource) {
      return {
        queryUser: ()=> {
          return $resource('/api/v1/users/users',{}, {
            query: {
              method: 'GET',
              isArray: false
            }
          });
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