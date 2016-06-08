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

            $locationProvider.html5Mode('true');
            $urlRouterProvider.otherwise('/');

            $stateProvider
                // .state('root', {
                //     url: '/',
                //     templateUrl: 'app/components/news/news.tpl.html',
                //     controller: 'newsController',
                //     controllerAs: 'newsCtrl'
                // })
                .state('login', {
                    url: '/login',
                    templateUrl: 'assets/app/components/auth/login/login.tpl.html',
                    controller: 'loginController',
                    controllerAs: 'loginCtrl'
                })
                .state('register', {
                    url: '/register',
                    templateUrl: 'assets/app/components/auth/register/reg.tpl.html',
                    controller: 'registerController',
                    controllerAs: 'regCtrl'
                });

        }]);