'use strict';

(function() {

  function LogoutFactoryService($http) {

    return {
      logout: function () {
        return $http.delete('api/v1/logout');
      }
    };
  }

  angular.module('ngSpaApp')
    .factory('LogoutFactory', LogoutFactoryService);
})();