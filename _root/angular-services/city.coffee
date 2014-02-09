# The city CRUD


services.factory 'city', ['$window', 'gdpCoefficients', 'cityObject', ($window, gdpCoefficients, cityObject) ->
  class City 

    constructor: (cityId) ->
      @cityId = cityId
      @assets = if localStorage['cities.' + cityId] then JSON.parse(localStorage['cities.' +  cityId]) else new Object() 

      if typeof @assets.creationDate == 'undefined'
        @assets.creationDate = new Date()
      
      @assets.objects = @assets.objects || [] 
    
    save: ->
      localStorage['cities.' + @cityId] = JSON.stringify @assets
     
    getElementTotal: (coefficientLevel) ->
      try 
        return @assets.objects.reduce (total, element) ->
          if typeof total == 'number'
            return total + element.info.benefit[coefficientLevel]
          else
            return 0
      catch
       return 0 

    addItem: (item) ->
     
      @assets.objects.push(item)

    getGdp: (years) ->
      # Retrieve the linear coefficient total
      linTotal = @getElementTotal('LIN')
      quadTotal = @getElementTotal('QUAD')
      cubeTotal = @getElementTotal('CUBE')     

      total = 
        linTotal * Math.pow(years, gdpCoefficients.LIN) +
        quadTotal * Math.pow(years, gdpCoefficients.QUAD) +
        cubeTotal * Math.pow(years, gdpCoefficients.CUBE)
      return total || 0

    # GDP intergrated
    getTotal: (years) ->
      # Retrieve the linear coefficient total
      linTotal = @getElementTotal('LIN')
      quadTotal = @getElementTotal('QUAD')
      cubeTotal = @getElementTotal('CUBE')     
      

      total = 
        ((linTotal * Math.pow(years, gdpCoefficients.LIN + 1)) / 2) +
        ((quadTotal * Math.pow(years, gdpCoefficients.QUAD + 1)) / 3) +
        ((cubeTotal * Math.pow(years, gdpCoefficients.CUBE + 1)) / 4)
      return total || 0

    getGdpCurrent: ->
      return @getGdp @getAge()

    getTotalCurrent: ->
      return @getTotal @getAge() 

    getAge: ->
      today = new Date()
      return (today - (new Date(@assets.creationDate))) / (1000 * 60 * 60)

    # Increases by 100 every year
    getPopulation: ->
      return @getAge() * 100
]
services.factory 'cityId', ->
  return 0
