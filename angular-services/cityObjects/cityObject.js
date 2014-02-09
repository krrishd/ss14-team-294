services.factory('cityObject', [
  '$resource', '$window', function($resource, $window) {
    var CityObject;
    CityObject = (function() {
      CityObject.prototype.getGdpIncreasePercentage = function(city, years) {
        var gdpIncrease, percentage;
        gdpIncrease = this.gdpValue * Math.pow(years, this.gdpType);
        percentage = gdpIncrease / (gdpIncrease + city.getGdp());
        return percentage;
      };

      CityObject.prototype.getKivaSector = function() {
        return this.kivaSector;
      };

      CityObject.prototype.getSectorDescription = function() {
        return this.sectorManipulator.getSectorDescription(this.getKivaSector());
      };

      function CityObject(type) {
        var catalogDictionaryObject, outer;
        outer = this;
        catalogDictionaryObject = $resource('./content/marketplace.json').get(function(data) {
          return outer.info = (data.content.filter(function(item) {
            return item.name.toLowerCase().replace(' ', '-') === type.toLowerCase().replace(' ', '-');
          }))[0];
        });
      }

      return CityObject;

    })();
    return CityObject;
  }
]);
