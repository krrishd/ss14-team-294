services.factory 'cityObject', ['$resource', '$window', 'gdpCoefficients',  ($resource, $window, gdpCoefficients) ->
      
  # The template of all city objects

  class CityObject 
    getGdpIncreasePercentage: (city, years) ->
      gdpIncrease = @getGdpIncrease years 
      percentage = gdpIncrease / 
        (gdpIncrease + city.getGdp(years))

      return Math.round(percentage)

    getGdpIncrease: (years) ->
      @info.benefit.LIN * Math.pow(years, gdpCoefficients.LINCO * gdpCoefficients.LIN) +
      @info.benefit.QUAD * Math.pow(years, gdpCoefficients.QUADCO * gdpCoefficients.QUAD) +
      @info.benefit.CUBE * Math.pow(years, gdpCoefficients.CUBECO * gdpCoefficients.CUBE)
    
     
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
