'use strict';

class employeesController {
  constructor(employeesFactory) {

    var allUsers = null;
    this.activeTabs = 1;
    employeesFactory.getUsers().then( (response)=>{
      allUsers = response.data.data;
      this.users = employeesFactory.filtered(1, allUsers);
    });
    
    this.setTabs = (n) => {
      this.users = employeesFactory.filtered(n, allUsers);
      this.activeTabs = n;
    };
  }
}

// employeesController.$inject = ['employeesFactory'];

angular.module('ngSpaApp')
  .controller('employeesController', employeesController);