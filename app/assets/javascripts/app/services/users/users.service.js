'use strict';

(function() {

  function usersService($http, FayeClient) {
    this.userStatuses = ['offline', 'online', 'away'];

    return {
      getProfile: function() {
        return $http.get('/api/v1/users/profile');
      },

      getUsers: function() {
        return $http.get('/api/v1/users/users');
      },

      deleteUser: function(id) {
        return $http.destroy('/api/v1/users/'+id);
      },

      getUser: function(id) {
        return $http.get('/api/v1/users/'+id);
      },

      userStatusUpdate: function(id, thisStatus)  {
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
