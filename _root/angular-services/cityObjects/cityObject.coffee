services.factory 'cityObject', ['$resource', '$window', ($resource, $window) ->
      
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

      outer = @
      catalogDictionaryObject = $resource('./content/marketplace.json').get (data) ->
        outer.info = (data.content.filter (item) ->
          return item.name.toLowerCase().replace(' ', '-') == type.toLowerCase().replace(' ', '-'))[0]
       
    
  return CityObject
]
