angular
    .module('ngSpaApp', [
        'ui.router',
        'ngMessages',
        'ngAnimate',
        'angular-storage',
        'ui.bootstrap',
        'ngResource',
        'sticky'
    ])
    .constant('CONFIG',
        {
            APIHost: 'http://localhost:3000'
        });