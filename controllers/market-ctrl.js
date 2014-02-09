app.controller('MarketCtrl', [
  '$scope', '$resource', function($scope, $resource) {
    return $resource('./content/marketplace.json').get(function(data) {
      return $scope.items = data.content;
    });
  }
]);
