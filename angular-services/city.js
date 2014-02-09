services.factory('city', [
  '$window', 'gdpCoefficients', 'cityObject', function($window, gdpCoefficients, cityObject) {
    var City;
    return City = (function() {
      function City(cityId) {
        this.cityId = cityId;
        this.assets = localStorage['cities.' + cityId] ? JSON.parse(localStorage['cities.' + cityId]) : new Object();
        if (typeof this.assets.creationDate === 'undefined') {
          this.assets.creationDate = new Date();
        }
        this.assets.objects = this.assets.objects || [];
      }

      City.prototype.save = function() {
        return localStorage['cities.' + this.cityId] = JSON.stringify(this.assets);
      };

      City.prototype.getElementTotal = function(coefficientLevel) {
        try {
          return this.assets.objects.reduce(function(total, element) {
            if (typeof total === 'number') {
              return total + element.info.benefit[coefficientLevel];
            } else {
              return 0;
            }
          });
        } catch (_error) {
          return 0;
        }
      };

      City.prototype.addItem = function(item) {
        return this.assets.objects.push(item);
      };

      City.prototype.getGdp = function(years) {
        var cubeTotal, linTotal, quadTotal, total;
        linTotal = this.getElementTotal('LIN');
        quadTotal = this.getElementTotal('QUAD');
        cubeTotal = this.getElementTotal('CUBE');
        total = linTotal * Math.pow(years, gdpCoefficients.LIN) + quadTotal * Math.pow(years, gdpCoefficients.QUAD) + cubeTotal * Math.pow(years, gdpCoefficients.CUBE);
        return total || 0;
      };

      City.prototype.getTotal = function(years) {
        var cubeTotal, linTotal, quadTotal, total;
        linTotal = this.getElementTotal(gdpCoefficients.LIN);
        quadTotal = this.getElementTotal(gdpCoefficients.QUAD);
        cubeTotal = this.getElementTotal(gdpCoefficients.CUBE);
        total = ((linTotal * Math.pow(years, gdpCoefficients.LIN + 1)) / 2) + ((quadTotal * Math.pow(years, gdpCoefficients.QUAD + 1)) / 3) + ((cubeTotal * Math.pow(years, gdpCoefficients.CUBE + 1)) / 4);
        return total || 0;
      };

      City.prototype.getGdpCurrent = function() {
        return this.getGdp(this.getAge());
      };

      City.prototype.getTotalCurrent = function() {
        return this.getTotal(this.getAge());
      };

      City.prototype.getAge = function() {
        var today;
        today = new Date();
        return (today() - this.assets.creationDate) / (1000 * 60 * 60);
      };

      City.prototype.getPopulation = function() {
        return this.getAge() * 100;
      };

      return City;

    })();
  }
]);

services.factory('cityId', function() {
  return 0;
});
