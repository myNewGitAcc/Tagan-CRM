(function () {
    'use strict';

    angular
        .module('ngSpaApp')
        .controller('registerController', registerController);

    registerController.$inject = ['$location', '$state', 'store', 'authService'];

    function registerController($location, $state, store, authService) {
        var vm = this;
        vm.signInOpen = signInOpen;
        vm.signUpSubmit = signUpSubmit;
        
        function signInOpen() {
            $state.go('login')
        }

        function signUpSubmit(user_credentials) {
            authService.register(user_credentials).then(function (response) {
                console.log(response)
                // store.set('token', response.data.token);
                // $location.path('/');
            }, function (response) {
                vm.RegErrorsMsg = response.data.errors;
                vm.showRegError = true;
            })
        }



    }
})();