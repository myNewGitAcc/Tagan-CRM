'use strict';

class employeesController {
  constructor(employeesFactory, users, FayeClient) {

    this.activeTabs = 'management';

    users.getUsers().then( (response) => {
      this.users = response.data.data;
     // this.users = employeesFactory.filtered('management', allUsers);
    });

    FayeClient.subscribe('/user_statuses', function(payload) {
      console.log(payload);
    });

    this.setTabs = (n) => {
     // this.users = employeesFactory.filtered(n, allUsers);
      this.activeTabs = n;
    };
  }
}

employeesController.$inject = ['employeesFactory', 'users', 'FayeClient'];

angular.module('ngSpaApp')
  .controller('employeesController', employeesController);
