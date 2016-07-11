angular
    .module('ngSpaApp')
    .config([
        '$stateProvider',
        '$httpProvider',
        '$locationProvider',
        '$urlRouterProvider', function(
            $stateProvider,
            $httpProvider,
            $locationProvider,
            $urlRouterProvider) {

            $locationProvider.html5Mode(true);
            $urlRouterProvider.otherwise('/');

            $stateProvider
                .state('worktime', {
                    url: '/',
                    templateUrl: 'worktime/worktime.tpl.html',
                    controller: 'worktimeController',
                    controllerAs: 'worktimeCtrl'
                })
                .state('employees', {
                    url: '/employees',
                    templateUrl: 'employees/employees.tpl.html',
                    controller: 'employeesController',
                    controllerAs: 'employeesCtrl'
                })
                .state('worldtime', {
                    url: '/worldtime',
                    templateUrl: 'worldtime/worldtime.tpl.html',
                    controller: 'worldtimeController',
                    controllerAs: 'wtCtrl'
                });

    }]);