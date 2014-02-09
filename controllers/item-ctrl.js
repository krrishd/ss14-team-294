app.controller('ItemCtrl', [
  '$window', '$scope', '$routeParams', 'city', 'cityObject', 'cityId', function($window, $scope, $routeParams, City, cityObject, cityId) {
    var city, hypoCity, item, itemName;
    itemName = $routeParams.itemName;
    item = new cityObject(itemName);
    $scope.item = item;
    city = new City(cityId);
    hypoCity = new City(cityId);
    hypoCity.addItem(item);
    $scope.gdpComparison = {
      labels: ['Decade', '20 years', '50 years', 'Century'],
      datasets: [
        {
          fillColor: '#7779Ed',
          strokeColor: '#4A4DF0',
          pointColor: '#29068A',
          pointStrokeColor: '#1D0169',
          data: [10, 20, 50, 100].map(function(n) {
            return city.getGdp(n);
          })
        }, {
          fillColor: '#1CC414',
          strokeColor: '#129C0B',
          pointColor: '#0B5C06',
          pointStrokeColor: '#084205',
          data: [10, 20, 50, 100].map(function(n) {
            return hypoCity.getGdp;
          })
        }
      ]
    };
    $scope.purchaseItem = function() {
      city.addItem(item);
      return city.save();
    };
    $scope.city = city;
    return $window.city = city;
  }
]);
