
(function () {
    'use strict';

    angular
        .module('ngSpaApp')
        .controller('loginController', loginController);

    loginController.$inject = ['$location', '$state', 'authService', 'store'];

    function loginController($location, $state, authService, store) {
        var vm = this;
        vm.signUpOpen = signUpOpen;
        vm.signInSubmit = signInSubmit;
        vm.logout = logout ;

        function signUpOpen() {
            $state.go('register')
        }

        function signInSubmit(user_credentials) {
            authService.login(user_credentials).then(function (response) {

                console.log(response);
                // store.set('token', response.data.token);
                // $location.path('/');
            }, function (response) {
                vm.signInErrorMsg = response.data.error
                vm.showError = true;
            })
        }
        
        function logout() {
            authService.logout().then(function (response) {
                console.log(response);
            })
        }



    }
})();