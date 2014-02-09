# An individual page for an It

app.controller 'ItemCtrl', ['$window', '$scope', '$routeParams', 'city', 'cityObject','cityId', 'FutureGdpFilter', ($window, $scope, $routeParams, City, cityObject, cityId, FutureGdpFilter) ->
 
  # Grab a reference to the item
  itemName = $routeParams.itemName
  item = new cityObject itemName

  # Give the scope access to the item
  $scope.item = item
  
  # Retrieve the current city
  city = new City cityId

  # Expose the city
  $scope.city = city

 

  # Set a bar chart to the city's GDP contigent on 
  # purchase decision

  $scope.gdpComparison =


  
  # A function to purchase items
  $scope.purchaseItem = ->
    city.addItem item
    city.save()

  $scope.city = city
  $window.city = city
]

filters.filter 'FutureGdp', ->
  (input, item) ->
    
    gdpArray = ([10, 20, 50, 100].map (n) -> city.getGdp n)     
    gdpIncreaseArray = gdpArray.map (n) ->
      n + item.getGdpIncrease n

    return {
      labels: ['Decade', '20 years', '50 years', 'Century']
      datasets: [
        { fillColor: '#7779Ed'
        strokeColor: '#4A4DF0'
        pointColor: '#29068A'
        pointStrokeColor: '#1D0169'
        data: gdpArray } 
        ,
        { fillColor: '#1CC414'
        strokeColor: '#129C0B' 
        pointColor: '#0B5C06'
        pointStrokeColor: '#084205'
        data: FutureGdpFilter(gdpArray, item)} 
      ]}

filters.filter 'CashInYear', ->
  (input, item) ->
    try  
      if (typeof item.info)
        return item.getGdpIncrease(input) - item.getGdpIncrease(input -1) 
      else 
        return 0
    catch
      return 0

