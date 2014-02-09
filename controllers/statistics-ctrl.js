app.controller('StatisticsCtrl', [
  '$resource', '$window', '$scope', 'city', 'cityId', function($resource, $window, $scope, City, cityId) {
    var addToCount, city, gdpArray, itemCounts;
    city = new City(cityId);
    $scope.city = city;
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
    $resource('./content/marketplace.json').get(function(data) {
      var item, _i, _len, _ref, _results;
      _ref = data.content;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(addToCount(item));
      }
      return _results;
    });
    return $scope.itemCounts = itemCounts;
  }
]);

filters.filter('gdp', function() {
  return function(input, city) {
    return city.getGdp(input);
  };
});
