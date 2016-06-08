(function () {
    'use strict';

    angular
        .module('ngSpaApp')
        .factory('authService', authService);

    authService.$inject = ['CONFIG', '$http', 'store'];

    function authService(CONFIG, $http, store) {
        return {
            login: login,
            logout: logout,
            register: register
            // isAuth: isAuth
        };

        function login(user_credentials) {
            return $http.post(CONFIG.APIHost + '/access/login',
                {user: user_credentials},
                {headers: {'Content-Type': 'application/json' , 'Accept': 'application/json'}}
            )
        }

        function logout() {
            return $http.delete(CONFIG.APIHost + '/access/logout',
                {headers: {'Content-Type': 'application/json' , 'Accept': 'application/json'}}
            )
        }
        //
        function register(user_credentials) {
            return $http.post(CONFIG.APIHost + '/access',
                {user: user_credentials},
                {headers: {'Content-Type': 'application/json' , 'Accept': 'application/json'}}
            )
        }
        //
        // function isAuth() {
        //     var token = store.get('token');
        //     // A token is present
        //     if (token) {
        //         // Token with a valid JWT format XXX.YYY.ZZZ
        //         if (token.split('.').length === 3) {
        //             // Could be a valid JWT or an access token with the same format
        //             try {
        //                 var base64Url = token.split('.')[1];
        //                 var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        //                 var exp = JSON.parse($window.atob(base64)).exp;
        //                 // JWT with an optonal expiration claims
        //                 if (exp) {
        //                     var isExpired = Math.round(new Date().getTime() / 1000) >= exp;
        //                     if (isExpired) {
        //                         // FAIL: Expired token
        //                         return false;
        //                     } else {
        //                         // PASS: Non-expired token
        //                         return true;
        //                     }
        //                 }
        //             } catch(e) {
        //                 // PASS: Non-JWT token that looks like JWT
        //                 return true;
        //             }
        //         }
        //         // PASS: All other tokens
        //         return true;
        //     }
        //     // FAIL: No token at all
        //     return false;
        // }

    }
})();