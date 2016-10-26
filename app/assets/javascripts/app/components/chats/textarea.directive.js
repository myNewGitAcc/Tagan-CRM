angular.module('ngSpaApp')
.directive('noNewLines', function() {
  return {
    restrict: 'A',
    require: 'ngModel',
    link: function(scope, element, attributes, ngModelController) {
      var model = attributes.ngModel;
      var regex = new RegExp("^[^\n\r]*$");

      ngModelController.$parsers.unshift(function(value) {
        if(!value) return value;
        var modelValue = ngModelController.$modelValue;
        var isValid = regex.test(value);
        ngModelController.$setValidity('Does not match pattern', isValid);

        var transformedInput = value.replace(/[\n\r]/g, '');
        if(transformedInput !== value) {
          ngModelController.$setViewValue(transformedInput);
          ngModelController.$render();
        }
        return transformedInput;
      });

      ngModelController.$formatters.unshift(function(value) {
        if(!value) return value;
        var isValid = regex.test(value);
        ngModelController.$setValidity('Does not match pattern', isValid);
        return value;
      });

      element.on('keypress', function(e) {
        var char = String.fromCharCode(e.which);
        var text = angular.element(e.srcElement).val();
        if(!regex.test(char) || !regex.test(text)) {
          e.preventDefault();
        }
      });

    }
  };
});