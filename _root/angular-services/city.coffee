# The city CRUD

class City 
  constructor: (cityId) ->
    @assets = if localStorage['cities.' + cityId] then JSON.parse(localStorage['cities.' +  cityId]) else new Object() 

    if typeof assets.creationDate == 'undefined'
      @assets.creationDate = new Date()
    
    @assets.objects == [] if @assets.objects == null
  
  getElementTotal = (coefficientLevel) ->
    return @assets.objects.reduce (total, element) ->
      return total + element.gdpValue if gdpCoefficient == coefficientLevel 

  getGdp: ->
    # Retrieve the linear coefficient total
    linTotal = getElementTotal(gdpCoefficient.LIN)
    quadTotal = getElementTotal(gdpCoefficient.QUAD)
    cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

    # Return the total number
    years = @getAge()

    total = 
      linTotal * Math.pow(years, 1) +
      quadTotal * Math.pow(years, 2) +
      cubeTotal * Math.pow(years, 3)

  # GDP intergrated
  getTotal: ->
    # Retrieve the linear coefficient total
    linTotal = getElementTotal(gdpCoefficient.LIN)
    quadTotal = getElementTotal(gdpCoefficient.QUAD)
    cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

    # Return the total number
    years = @getAge()

    total = 
      ((linTotal * Math.pow(years, 2)) / 2) +
      ((quadTotal * Math.pow(years, 3)) / 3) +
      ((cubeTotal * Math.pow(years, 4)) / 4)

  getAge: ->
    today = new Date()
    return (today() - @assets.creationDate) / (1000 * 60 * 60)

  # Increases by 100 every year
  getPopulation: ->
    return @getAge() * 100


  gdpCoefficients = 
    LIN: 0
    QUAD: 1
    CUBE : 2

f = new City()
app.factory 'city', ->
  return new City()
