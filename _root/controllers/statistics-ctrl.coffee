app.controller 'StatisticsCtrl', ['$window', '$scope', '$routeParams', 'city', 'cityObject','cityId', ($window, $scope, $routeParams, City, cityObject, cityId) ->
  city = new City cityId

  $scope.city = city
  $scope.h = 1
  $window.alert (1)
  gdpArray = ([10, 20, 50, 100].map (n) -> city.getGdp n)

  $scope.gdpComparison =
    labels: ['Decade', '20 years', '50 years', 'Century']
    datasets: [
      { fillColor: '#7779Ed'
      strokeColor: '#4A4DF0'
      pointColor: '#29068A'
      pointStrokeColor: '#1D0169'
      data: gdpArray } 
    ]
]
