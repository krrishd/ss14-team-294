# The city CRUD

class City 
  constructor: (cityId) ->
    @assets = JSON.parse localStorage['cities.' +  cityId]

    if typeof assets.creationDate == 'undefined'
      @assets.creationDate = new Date()

    if typeof assets.population == 'undefined'
      @assets.population = 100
   
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
  
  getAge: ->
    today = new Date()
    return today().getFullYear() - @assets.creationDate.getFullYear()

  getPopulation: ->
    return @assets.population

  gdpCoefficients = 
    LIN: 0
    QUAD: 1
    CUBE : 2
