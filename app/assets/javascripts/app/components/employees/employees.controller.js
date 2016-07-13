'use strict';

class employeesController {
  constructor(employeesFactory, users, FayeClient, $scope) {
    var controllerThis = this;
    this.activeTabs = 'management';

    users.getUsers().then( (response) => {
      this.users = response.data.data;
    });

    FayeClient.subscribe('/user_statuses', function(payload) {
      $scope.$apply(()=>{
        controllerThis.users = employeesFactory.filtered(payload, controllerThis.users);
      })

    });

    this.setTabs = (n) => {
      this.activeTabs = n;
    };
  }
}

employeesController.$inject = ['employeesFactory', 'users', 'FayeClient', '$scope'];

angular.module('ngSpaApp')
  .controller('employeesController', employeesController);
