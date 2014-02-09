app.controller('RegisterCtrl', [
  '$scope', '$resource', '$window', 'cityObject', function($scope, $resource, $window, cityObject) {
    return $scope.registerUser = function() {
      $window.h = $resource('./content/marketplace.json').get();
      return $window.f = new cityObject('Shovel');
    };
  }
]);
