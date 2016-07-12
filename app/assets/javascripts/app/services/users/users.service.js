'use strict';

(function() {

  function usersService($http, FayeClient) {
    this.userStatuses = ['offline', 'online', 'away'];

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

      userStatusUpdate: (id, thisStatus) => {
        FayeClient.publish('/user_statuses', {status: this.userStatuses[thisStatus], id: id});

        return $http.put('/api/v1/users/'+id, {
          status: thisStatus
        });
      }
    };
  }
  usersService.$inject = ['$http', 'FayeClient'];

  angular.module('ngSpaApp')
    .factory('users', usersService);
})();
