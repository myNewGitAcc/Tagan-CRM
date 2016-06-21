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
                    templateUrl: 'assets/app/components/worktime/worktime.tpl.html',
                    controller: 'worktimeController',
                    controllerAs: 'worktimeCtrl'
                })
                .state('state1', {
                    url: '/state1',
                    templateUrl: 'assets/app/components/state1/state1.tpl.html',
                    controller: 'state1Controller',
                    controllerAs: 'state1Ctrl'
                })
                // .state('register', {
                //     url: '/register',
                //     templateUrl: 'assets/app/components/auth/register/reg.tpl.html',
                //     controller: 'registerController',
                //     controllerAs: 'regCtrl'
                // });

        }]);