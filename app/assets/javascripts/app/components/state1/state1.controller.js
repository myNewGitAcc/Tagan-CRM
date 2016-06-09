(function () {
    'use strict';
    angular
        .module('ngSpaApp')
        .controller('state1Controller', state1Controller);

    function state1Controller() {
        var vm = this;

        vm.message = 'This from angular state1'
    }
})();