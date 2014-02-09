var City;

City = (function() {
  var getElementTotal;

  function City(cityId) {
    this.assets = localStorage['cities.' + cityId] ? JSON.parse(localStorage['cities.' + cityId]) : new Object();
    if (typeof assets.creationDate === 'undefined') {
      this.assets.creationDate = new Date();
    }
    if (this.assets.objects === null) {
      this.assets.objects === [];
    }
  }

  getElementTotal = function(coefficientLevel) {
    return this.assets.objects.reduce(function(total, element) {
      if (element.gdpType === coefficientLevel) {
        return total + element.gdpValue;
      }
    });
  };

  City.prototype.getGdp = function() {
    var cubeTotal, linTotal, quadTotal, total, years;
    linTotal = getElementTotal(gdpCoefficient.LIN);
    quadTotal = getElementTotal(gdpCoefficient.QUAD);
    cubeTotal = getElementTotal(gdpCoefficient.CUBE);
    years = this.getAge();
    total = linTotal * Math.pow(years, gdpCoefficient.LIN) + quadTotal * Math.pow(years, gdpCoefficient.QUAD) + cubeTotal * Math.pow(years, gdpCoefficient.CUBE);
    return total;
  };

  City.prototype.getTotal = function() {
    var cubeTotal, linTotal, quadTotal, total, years;
    linTotal = getElementTotal(gdpCoefficient.LIN);
    quadTotal = getElementTotal(gdpCoefficient.QUAD);
    cubeTotal = getElementTotal(gdpCoefficient.CUBE);
    years = this.getAge();
    total = ((linTotal * Math.pow(years, gdpCoefficient.LIN + 1)) / 2) + ((quadTotal * Math.pow(years, gdpCoefficient.QUAD + 1)) / 3) + ((cubeTotal * Math.pow(years, gdpCoefficient.CUBE + 1)) / 4);
    return total;
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

services.factory('city', function() {
  return City();
});

services.factory('cityId', function() {
  return 0;
});
