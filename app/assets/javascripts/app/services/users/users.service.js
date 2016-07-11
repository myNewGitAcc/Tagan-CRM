'use strict';

(function() {

  function usersService($http) {

    return {
      getProfile: ()=> {
        return $http.get('/api/v1/users/profile');
      },

      getUsers: ()=> {
        return $http.get('/api/v1/users/users');
      },

      deleteUser: (id)=> {
        return $http.destroy('/api/v1/users/'+id);
      },
      
      getUser: (id) => {
        return $http.get('/api/v1/users/'+id);
      },

      userStatusUpdate: (id, thisStatus)=> {
        return $http.put('/api/v1/users/'+id, {
          status: thisStatus
        });
      }
    };
  }
  usersService.$inject = ['$http'];

  angular.module('ngSpaApp')
    .factory('users', usersService);
})();