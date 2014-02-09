services.factory('cityObject', [
  '$resource', '$window', 'gdpCoefficients', function($resource, $window, gdpCoefficients) {
    var CityObject;
    CityObject = (function() {
      CityObject.prototype.getGdpIncreasePercentage = function(city, years) {
        var gdpIncrease, percentage;
        gdpIncrease = this.getGdpIncrease(years);
        percentage = gdpIncrease / (gdpIncrease + city.getGdpCurrent());
        return percentage;
      };

      CityObject.prototype.getGdpIncrease = function(years) {
        return this.info.benefit.LIN * Math.pow(years, gdpCoefficients.LIN) + this.info.benefit.QUAD * Math.pow(years, gdpCoefficients.QUAD) + this.info.benefit.CUBE * Math.pow(years, gdpCoefficients.CUBE);
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
