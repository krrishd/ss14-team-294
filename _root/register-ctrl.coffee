app.controller 'RegisterCtrl', ['$scope', '$resource', '$window', 'cityObject', ($scope, $resource, $window, cityObject) ->
  $scope.registerUser = ->
    $window.h = ($resource('./content/marketplace.json').get())
    $window.f = new cityObject('Shovel') 
]
