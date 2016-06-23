'use strict';

class employeesController {
  constructor(employeesFactory) {

    var allUsers = null;
    this.activeTabs = 1;
    employeesFactory.queryUser().query((response)=>{
      allUsers = response.data;
      this.users = employeesFactory.filtered(1, allUsers);
    });
    
    this.setTabs = (n) => {
      this.users = employeesFactory.filtered(n, allUsers);
      this.activeTabs = n;
    };
  }
}

angular.module('ngSpaApp')
  .controller('employeesController', employeesController);