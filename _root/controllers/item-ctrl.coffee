# An individual page for an It

app.controller 'ItemCtrl', ['$resource', '$window', '$scope', '$routeParams', 'city', 'cityObject','cityId', 'FutureGdpFilter', ($resource, $window, $scope, $routeParams, City, cityObject, cityId, FutureGdpFilter) ->
 
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

  

  updateBalance = ->
    $scope.balance = city.getBalance()
    $scope.$apply()

  updateBalance()
  setInterval(updateBalance, 1000)

  # Set the default year to date
  $scope.ytd = 1

  # A function to purchase items
  $scope.purchaseItem = ->
    city.addItem item
    city.save()

  $resource('http://api.kivaws.org/v1/teams/search.json?q=' + itemName ).get (data) ->
    if data.teams.length > 0
      $scope.loan =  data.teams[0]
    else
      $resource('http://api.kivaws.org/v1/teams/search.json?category=Businesses').get (newData) ->
        $scope.loan =  newData.teams[0]
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

