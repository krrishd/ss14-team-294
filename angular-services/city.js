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
        if (this.assets.objects.length > 1) {
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
        }
      };

      City.prototype.getSpendingTotal = function() {
        return Math.round(this.getSpendingTotalRaw());
      };

      City.prototype.getSpendingTotalRaw = function() {
        if (this.assets.objects.length > 1) {
          try {
            return this.assets.objects.reduce(function(total, element) {
              if (typeof total === 'number') {
                return total + element.info.cost;
              } else {
                return 0;
              }
            });
          } catch (_error) {
            return 0;
          }
        } else {
          return 0;
        }
      };

      City.prototype.getBalance = function() {
        return this.getTotalCurrent() - this.getSpendingTotal() + 1000;
      };

      City.prototype.getBalancePredicted = function(years) {
        return this.getTotal(years) - this.getSpendingTotal() + 1000;
      };

      City.prototype.addItem = function(item) {
        if ((this.getBalance() - item.info.cost) >= 0) {
          return this.assets.objects.push(item);
        } else {
          return $window.alert('This item is too expensive');
        }
      };

      City.prototype.getGdp = function(years) {
        var cubeTotal, linTotal, quadTotal, total;
        linTotal = this.getElementTotal('LIN');
        quadTotal = this.getElementTotal('QUAD');
        cubeTotal = this.getElementTotal('CUBE');
        total = linTotal * Math.pow(years, gdpCoefficients.LINCO * gdpCoefficients.LIN) + quadTotal * Math.pow(years, gdpCoefficients.QUADCO * gdpCoefficients.QUAD) + cubeTotal * Math.pow(years, gdpCoefficients.CUBECO * gdpCoefficients.CUBE);
        if ((total > 10000) && (localStorage['hasTycoon'] !== true)) {
          $window.alert("Congratulations! You have reached tycoon status!");
          localStorage['hasTycoon'] = true;
        }
        return Math.round(total) || 0;
      };

      City.prototype.getTotal = function(years) {
        var cubeTotal, linTotal, quadTotal, total;
        linTotal = this.getElementTotal('LIN');
        quadTotal = this.getElementTotal('QUAD');
        cubeTotal = this.getElementTotal('CUBE');
        total = ((linTotal * Math.pow(years, gdpCoefficients.LINCO * gdpCoefficients.LIN + 1)) / 2) + ((quadTotal * Math.pow(years, gdpCoefficients.QUADCO * gdpCoefficients.QUAD + 1)) / 3) + ((cubeTotal * Math.pow(years, gdpCoefficients.CUBECO * gdpCoefficients.CUBE + 1)) / 4);
        return Math.round(total) || 0;
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
        return (today - (new Date(this.assets.creationDate))) / (1000 * 5 * 1);
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
