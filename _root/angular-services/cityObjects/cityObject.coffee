services.factory 'cityObject', ['$resource', '$window', 'gdpCoefficients',  ($resource, $window, gdpCoefficients) ->
      
  # The template of all city objects

  class CityObject 
    getGdpIncreasePercentage: (city, years) ->
      gdpIncrease = @getGdpIncrease years 
      percentage = gdpIncrease / 
        (gdpIncrease + city.getGdpCurrent())

      return Math.round(percentage)

    getGdpIncrease: (years) ->
      @info.benefit.LIN * Math.pow(gdpCoefficients.LINCO * years, gdpCoefficients.LIN) +
      @info.benefit.QUAD * Math.pow(gdpCoefficients.QUADCO * years, gdpCoefficients.QUAD) +
      @info.benefit.CUBE * Math.pow(gdpCoefficients.CUBECO * years, gdpCoefficients.CUBE)
    
     
    getKivaSector: ->
      return @kivaSector
   
    # The sector manipulator is only concrete in the children
    getSectorDescription: ->
      return @sectorManipulator.getSectorDescription @getKivaSector()

    # Retrieves information on the item when being initialized
    constructor: (type) ->

      outer = @
      catalogDictionaryObject = $resource('./content/marketplace.json').get (data) ->
        outer.info = (data.content.filter (item) ->
          return item.name.toLowerCase().replace(' ', '-') == type.toLowerCase().replace(' ', '-'))[0]
       
    
  return CityObject
]
