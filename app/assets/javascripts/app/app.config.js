angular
    .module('ngSpaApp', [
        'ui.router',
        'ngMessages',
        'ngAnimate',
        'angular-storage',
        'ui.bootstrap',
        'ngResource',
        'sticky',
        'templates',
        'luegg.directives',
        'notification'
    ])
    .constant('CONFIG', {
        APIHost: 'http://localhost:3000'
    })
    .run(($rootScope, users)=>{
      users.getProfile().then((response)=>{
        $rootScope.currentUserName = response.data.data.full_name;
        $rootScope.currentUserId = response.data.data.id;
      });
    })
    .factory('FayeClient', [
      function() {
        return new Faye.Client('/faye')
      }
    ]);
