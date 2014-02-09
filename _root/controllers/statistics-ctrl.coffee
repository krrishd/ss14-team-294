app.controller 'StatisticsCtrl', ['$window', '$scope', 'city', 'cityId', ($window, $scope, City, cityId) ->
  city = new City cityId

  $scope.city = city

  $window.city = city
  gdpArray = ([10, 20, 50, 100].map (n) -> city.getGdp n)

  $scope.gdpGrowth=
    labels: ['Decade', '20 years', '50 years', 'Century']
    datasets: [
      { fillColor: '#7779Ed'
      strokeColor: '#4A4DF0'
      pointColor: '#29068A'
      pointStrokeColor: '#1D0169'
      data: gdpArray } 
    ]

    #$scope.gdp = $scope.city.getGdp $scope.years
]

filters.filter 'gdp', ->
  (input, city) ->
    return city.getGdp input
