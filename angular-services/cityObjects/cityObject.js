services.factory('cityObject', [
  '$resource', function() {
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
        var catalogDictionaryObject;
        catalogDictionaryObject = $resource('./content/marketplace.json').get();
        this.info = catalogDictionaryObject.content.filter(function(item) {
          return item.name === type;
        });
      }

      return CityObject;

    })();
    return CityObject;
  }
]);
