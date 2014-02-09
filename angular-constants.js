services.factory('gdpCoefficients', function() {
  var gdpCoefficients;
  gdpCoefficients = {
    LIN: 1,
    QUAD: 2,
    CUBE: 3,
    LINCO: .2,
    QUADCO: .7,
    CUBECO: 1
  };
  return gdpCoefficients;
});
