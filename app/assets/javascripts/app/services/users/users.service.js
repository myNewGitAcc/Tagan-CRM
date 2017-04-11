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

      userStatusUpdate: (id, hours, thisStatus) => {
        FayeClient.publish('/user_statuses', {hours: hours, status: this.userStatuses[thisStatus], id: id});

        return $http.put('/api/v1/users/'+id, {
          status: thisStatus
        });
      },

      userHoursUpdate: (id, hours, thisStatus) => {
        FayeClient.publish('/user_hours', {hours: hours, status: thisStatus, id: id});
      }
    };
  }
  usersService.$inject = ['$http', 'FayeClient'];

  angular.module('ngSpaApp')
    .factory('users', usersService);
})();
