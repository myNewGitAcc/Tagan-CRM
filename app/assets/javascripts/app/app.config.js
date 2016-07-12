angular
    .module('ngSpaApp', [
        'ui.router',
        'ngMessages',
        'ngAnimate',
        'angular-storage',
        'ui.bootstrap',
        'ngResource',
        'sticky',
        'templates'
    ])
    .constant('CONFIG',
        {
            APIHost: 'http://localhost:3000'
        })
    .run(($rootScope, users)=>{
      users.getProfile().then((response)=>{
        $rootScope.currentUserId = response.data.data.id;
      });
    })
    .factory('FayeClient', [
      function() {
        return new Faye.Client('/faye')
      }
    ]);
