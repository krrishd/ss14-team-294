services.factory 'cityObject', ['$resource', ->
      
  # The template of all city objects

  class CityObject 
    getGdpIncreasePercentage: (city, years) ->
      gdpIncrease = @gdpValue * Math.pow years, @gdpType
      percentage = gdpIncrease / 
        (gdpIncrease + city.getGdp())

      return percentage

    getKivaSector: ->
      return @kivaSector
   
    # The sector manipulator is only concrete in the children
    getSectorDescription: ->
      return @sectorManipulator.getSectorDescription @getKivaSector()

    # Retrieves information on the item when being initialized
    constructor: (type) ->
      catalogDictionaryObject = $resource('./content/marketplace.json').get()
      @info = catalogDictionaryObject.content.filter (item) ->
        return item.name == type
    
  return CityObject
]
