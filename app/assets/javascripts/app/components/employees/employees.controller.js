'use strict';

class employeesController {
  constructor(employeesFactory, users) {

    var allUsers = null;
    this.activeTabs = 'management';
    users.getUsers().then( (response)=>{
      this.users = response.data.data;
     // this.users = employeesFactory.filtered('management', allUsers);
    });
    
    this.setTabs = (n) => {
     // this.users = employeesFactory.filtered(n, allUsers);
      this.activeTabs = n;
    };
  }
}

employeesController.$inject = ['employeesFactory', 'users'];

angular.module('ngSpaApp')
  .controller('employeesController', employeesController);