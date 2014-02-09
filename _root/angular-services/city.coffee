# The city CRUD

class City 
  constructor: (cityId) ->
    @assets = if localStorage['cities.' + cityId] then JSON.parse(localStorage['cities.' +  cityId]) else new Object() 

    if typeof assets.creationDate == 'undefined'
      @assets.creationDate = new Date()
    
    @assets.objects == [] if @assets.objects == null
  
  getElementTotal = (coefficientLevel) ->
    return @assets.objects.reduce (total, element) ->
      return total + element.gdpValue if element.gdpType == coefficientLevel 

  getGdp: ->
    # Retrieve the linear coefficient total
    linTotal = getElementTotal(gdpCoefficient.LIN)
    quadTotal = getElementTotal(gdpCoefficient.QUAD)
    cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

    # Return the total number
    years = @getAge()

    total = 
      linTotal * Math.pow(years, gdpCoefficient.LIN) +
      quadTotal * Math.pow(years, gdpCoefficient.QUAD) +
      cubeTotal * Math.pow(years, gdpCoefficient.CUBE)
    return total

  # GDP intergrated
  getTotal: ->
    # Retrieve the linear coefficient total
    linTotal = getElementTotal(gdpCoefficient.LIN)
    quadTotal = getElementTotal(gdpCoefficient.QUAD)
    cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

    # Return the total number
    years = @getAge()

    total = 
      ((linTotal * Math.pow(years, gdpCoefficient.LIN + 1)) / 2) +
      ((quadTotal * Math.pow(years, gdpCoefficient.QUAD + 1)) / 3) +
      ((cubeTotal * Math.pow(years, gdpCoefficient.CUBE + 1)) / 4)
    return total

  getAge: ->
    today = new Date()
    return (today() - @assets.creationDate) / (1000 * 60 * 60)

  # Increases by 100 every year
  getPopulation: ->
    return @getAge() * 100

appServices.factory 'city', ->
  return City()

appServices.factory 'cityId', ->
  return 0
