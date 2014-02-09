# The city CRUD


services.factory 'city', ['cityObject', (cityObject) ->
  class City 
    constructor: (cityId) ->
      @assets = if localStorage['cities.' + cityId] then JSON.parse(localStorage['cities.' +  cityId]) else new Object() 

      if typeof assets.creationDate == 'undefined'
        @assets.creationDate = new Date()
      
      @assets.objects == [] if @assets.objects == null
    
    getElementTotal = (coefficientLevel) ->
      return @assets.objects.reduce (total, element) ->
        return total + element.benefit[coefficientLevel]

    addItem: (item) ->
      object = new cityObject(item)
      @assets.objects.push(item)

    getGdp: (years) ->
      # Retrieve the linear coefficient total
      linTotal = getElementTotal(gdpCoefficient.LIN)
      quadTotal = getElementTotal(gdpCoefficient.QUAD)
      cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

      total = 
        linTotal * Math.pow(years, gdpCoefficient.LIN) +
        quadTotal * Math.pow(years, gdpCoefficient.QUAD) +
        cubeTotal * Math.pow(years, gdpCoefficient.CUBE)
      return total || 0

    # GDP intergrated
    getTotal: (years) ->
      # Retrieve the linear coefficient total
      linTotal = getElementTotal(gdpCoefficient.LIN)
      quadTotal = getElementTotal(gdpCoefficient.QUAD)
      cubeTotal = getElementTotal(gdpCoefficient.CUBE)     

      total = 
        ((linTotal * Math.pow(years, gdpCoefficient.LIN + 1)) / 2) +
        ((quadTotal * Math.pow(years, gdpCoefficient.QUAD + 1)) / 3) +
        ((cubeTotal * Math.pow(years, gdpCoefficient.CUBE + 1)) / 4)
      return total || 0

    getGdpCurrent: ->
      return @getGdp @getAge()

    getTotalCurrent: ->
      return @getTotal @getAge()

    getAge: ->
      today = new Date()
      return (today() - @assets.creationDate) / (1000 * 60 * 60)

    # Increases by 100 every year
    getPopulation: ->
      return @getAge() * 100
]
services.factory 'cityId', ->
  return 0
