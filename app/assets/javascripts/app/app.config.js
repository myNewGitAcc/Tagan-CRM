angular
    .module('ngSpaApp', [
        'ui.router',
        'ngMessages',
        'ngAnimate',
        'angular-storage',
        'ui.bootstrap',
        'ngResource'
    ])
    .constant('CONFIG',
        {
            APIHost: 'http://localhost:3000'
        });