app.controller('StatisticsCtrl', [
  '$window', '$scope', 'city', 'cityId', function($window, $scope, City, cityId) {
    var city, gdpArray;
    city = new City(cityId);
    $scope.city = city;
    $window.city = city;
    gdpArray = [10, 20, 50, 100].map(function(n) {
      return city.getGdp(n);
    });
    return $scope.gdpGrowth = {
      labels: ['Decade', '20 years', '50 years', 'Century'],
      datasets: [
        {
          fillColor: '#7779Ed',
          strokeColor: '#4A4DF0',
          pointColor: '#29068A',
          pointStrokeColor: '#1D0169',
          data: gdpArray
        }
      ]
    };
  }
]);

filters.filter('gdp', function() {
  return function(input, city) {
    return city.getGdp(input);
  };
});
