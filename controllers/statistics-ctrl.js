app.controller('StatisticsCtrl', [
  '$resource', '$window', '$scope', 'city', 'cityId', function($resource, $window, $scope, City, cityId) {
    var addToCount, city, gdpArray, itemCounts, updateAge, updateBalance;
    city = new City(cityId);
    $scope.city = city;
    updateBalance = function() {
      $scope.balance = city.getBalance();
      return $scope.$apply();
    };
    setInterval(updateBalance, 1000);
    updateAge = function() {
      $scope.age = city.getAge();
      return $scope.$apply();
    };
    setInterval(updateAge, 1000);
    $window.city = city;
    gdpArray = [10, 20, 50, 100].map(function(n) {
      return city.getGdp(n);
    });
    $scope.gdpGrowth = {
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
    itemCounts = [];
    addToCount = function(item) {
      var items;
      items = city.assets.objects.filter(function(element) {
        return item.name === element.info.name;
      });
      return itemCounts.push({
        name: item.name,
        count: items.length
      });
    };
    return $resource('./content/marketplace.json').get(function(data) {
      var item, itemLabels, itemNumbers, _i, _len, _ref;
      _ref = data.content;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        addToCount(item);
      }
      $scope.itemCounts = itemCounts;
      itemLabels = itemCounts.map(function(i) {
        return i.name;
      });
      itemNumbers = itemCounts.map(function(i) {
        return i.count;
      });
      $scope.itemChart = {
        labels: itemLabels,
        datasets: [
          {
            fillColor: '#7779Ed',
            strokeColor: '#4A4DF0',
            pointColor: '#29068A',
            pointStrokeColor: '#1D0169',
            data: itemNumbers
          }
        ]
      };
      return $scope.$apply();
    });
  }
]);

filters.filter('gdp', function() {
  return function(input, city) {
    return city.getGdp(input);
  };
});

filters.filter('balance', function() {
  return function(input, city) {
    return city.getBalancePredicted(input);
  };
});

filters.filter('total', function() {
  return function(input, city) {
    return city.getTotal(input);
  };
});
