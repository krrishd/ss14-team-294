app.controller('RegisterCtrl', [
  '$scope', '$resource', '$window', function($scope, $resource, $window) {
    return $scope.registerUser = function() {
      return $window.h = $resource('./content/marketplace.json').get();
    };
  }
]);
