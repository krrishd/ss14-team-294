app.controller 'RegisterCtrl', ['$scope', '$resource', '$window', ($scope, $resource, $window) ->
  $scope.registerUser = ->
    $window.h = ($resource('./content/marketplace.json').get())

]
