# Define the controller

app.controller 'MarketCtrl', ['$scope', '$resource', ($scope, $resource) ->
  $resource('./content/marketplace.json').get (data) ->
    $scope.items = data.content
]
