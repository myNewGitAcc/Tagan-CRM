(function () {
    'use strict';
    angular
        .module('ngSpaApp')
        .controller('rootController', rootController);
    
    function rootController() {
        var vm = this;
        
        vm.message = 'This from angular root state'
    }
})();