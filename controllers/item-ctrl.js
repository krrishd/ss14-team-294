app.controller('ItemCtrl', [
  '$scope', '$routeParams', 'city', 'cityObject', 'cityId', function($scope, $routeParams, City, cityObject, cityId) {
    var city, hypoCity, item, itemName, year;
    itemName = $routeParams.itemName;
    item = new cityObject(itemName);
    $scope.item = item;
    city = new City(cityId);
    hypoCity = new City(cityId);
    hypoCity.addItem(itemName);
    return $scope.gdpComparision = {
      labels: ['Decade', '20 years', '50 years', 'Century'],
      datasets: [
        {
          fillColor: '#7779Ed',
          strokeColor: '#4A4DF0',
          pointColor: '#29068A',
          pointStrokeColor: '#1D0169',
          data: (function() {
            var _i, _len, _ref, _results;
            _ref = [10, 20, 50, 100];
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              year = _ref[_i];
              _results.push(city.getGdp(year));
            }
            return _results;
          })(),
          fillColor: '#1CC414',
          strokeColor: '#129C0B',
          pointColor: '#0B5C06',
          pointStrokeColor: '#084205',
          data: (function() {
            var _i, _len, _ref, _results;
            _ref = [10, 20, 50, 100];
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              year = _ref[_i];
              _results.push(hypoCity.getGdp(year));
            }
            return _results;
          })()
        }
      ]
    };
  }
]);
