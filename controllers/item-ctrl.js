app.controller('ItemCtrl', [
  '$window', '$scope', '$routeParams', 'city', 'cityObject', 'cityId', 'FutureGdpFilter', function($window, $scope, $routeParams, City, cityObject, cityId, FutureGdpFilter) {
    var city, item, itemName;
    itemName = $routeParams.itemName;
    item = new cityObject(itemName);
    $scope.item = item;
    city = new City(cityId);
    $scope.city = city;
    $scope.gdpComparison = $scope.purchaseItem = function() {
      city.addItem(item);
      return city.save();
    };
    $scope.city = city;
    return $window.city = city;
  }
]);

filters.filter('FutureGdp', function() {
  return function(input, item) {
    var gdpArray, gdpIncreaseArray;
    gdpArray = [10, 20, 50, 100].map(function(n) {
      return city.getGdp(n);
    });
    gdpIncreaseArray = gdpArray.map(function(n) {
      return n + item.getGdpIncrease(n);
    });
    return {
      labels: ['Decade', '20 years', '50 years', 'Century'],
      datasets: [
        {
          fillColor: '#7779Ed',
          strokeColor: '#4A4DF0',
          pointColor: '#29068A',
          pointStrokeColor: '#1D0169',
          data: gdpArray
        }, {
          fillColor: '#1CC414',
          strokeColor: '#129C0B',
          pointColor: '#0B5C06',
          pointStrokeColor: '#084205',
          data: FutureGdpFilter(gdpArray, item)
        }
      ]
    };
  };
});

filters.filter('CashInYear', function() {
  return function(input, item) {
    try {
      if (typeof item.info) {
        return item.getGdpIncrease(input) - item.getGdpIncrease(input(-1));
      } else {
        return 0;
      }
    } catch (_error) {
      return 0;
    }
  };
});
