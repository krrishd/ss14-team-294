services.factory('gdpCoefficients', function() {
  var gdpCoefficients;
  gdpCoefficients = {
    LIN: 1,
    QUAD: 2,
    CUBE: 3,
    LINCO: .2,
    QUADCO: .01,
    CUBECO: .0001
  };
  return gdpCoefficients;
});
