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
      if @assets.objects.length > 1
        try 
          @assets.objects.reduce (total, element) ->
            if typeof total == 'number'
              return total + element.info.benefit[coefficientLevel]
            else
              return 0
        catch
         return 0 

    getSpendingTotal: ->
      Math.round(@getSpendingTotalRaw())
     
    getSpendingTotalRaw: ->
      if @assets.objects.length > 1
        try 
          @assets.objects.reduce (total, element) ->
            if typeof total == 'number'
              return total + element.info.cost
            else
              return 0
          
        catch
         return 0 
      else
        return 0

     getBalance: ->
       @getTotalCurrent() - @getSpendingTotal() + 1000

    getBalancePredicted: (years) ->
      @getTotal(years) - @getSpendingTotal() + 1000
    
    addItem: (item) ->
      if (@getBalance() - item.info.cost) > 0
        @assets.objects.push(item)
      else
        $window.alert('This item is too expensive')

    getGdp: (years) ->
      # Retrieve the linear coefficient total
      linTotal = @getElementTotal('LIN')
      quadTotal = @getElementTotal('QUAD')
      cubeTotal = @getElementTotal('CUBE')     

      total = 
        linTotal * Math.pow(gdpCoefficients.LINCO * years, gdpCoefficients.LIN) +
        quadTotal * Math.pow(gdpCoefficients.QUADCO * years, gdpCoefficients.QUAD) +
        cubeTotal * Math.pow(gdpCoefficients.CUBECO * years, gdpCoefficients.CUBE)
      return Math.round(total) || 0


    # GDP intergrated
    getTotal: (years) ->
      # Retrieve the linear coefficient total
      linTotal = @getElementTotal('LIN')
      quadTotal = @getElementTotal('QUAD')
      cubeTotal = @getElementTotal('CUBE')     
      

      total = 
        ((linTotal * Math.pow(gdpCoefficients.LINCO * years, gdpCoefficients.LIN + 1)) / 2) +
        ((quadTotal * Math.pow(gdpCoefficients.QUADCO * years, gdpCoefficients.QUAD + 1)) / 3) +
        ((cubeTotal * Math.pow(gdpCoefficients.CUBECO * years, gdpCoefficients.CUBE + 1)) / 4)
      return Math.round(total) || 0

    getGdpCurrent: ->
      return @getGdp @getAge()

    getTotalCurrent: ->
      return @getTotal @getAge() 

    getAge: ->
      today = new Date()
      return (today - (new Date(@assets.creationDate))) / (1000 * 5 * 1) 

    # Increases by 100 every year
    getPopulation: ->
      return @getAge() * 100
]
services.factory 'cityId', ->
  return 0
