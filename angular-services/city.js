var City;

City = (function() {
  var gdpCoefficients, getElementTotal;

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
      if (gdpCoefficient === coefficientLevel) {
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
    total = linTotal * Math.pow(years, 1) + quadTotal * Math.pow(years, 2) + cubeTotal * Math.pow(years, 3);
    return total;
  };

  City.prototype.getTotal = function() {
    var cubeTotal, linTotal, quadTotal, total, years;
    linTotal = getElementTotal(gdpCoefficient.LIN);
    quadTotal = getElementTotal(gdpCoefficient.QUAD);
    cubeTotal = getElementTotal(gdpCoefficient.CUBE);
    years = this.getAge();
    total = ((linTotal * Math.pow(years, 2)) / 2) + ((quadTotal * Math.pow(years, 3)) / 3) + ((cubeTotal * Math.pow(years, 4)) / 4);
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

  gdpCoefficients = {
    LIN: 0,
    QUAD: 1,
    CUBE: 2
  };

  return City;

})();

appServices.factory('city', function() {
  return City();
});

appServices.factory('cityId', function() {
  return 0;
});
