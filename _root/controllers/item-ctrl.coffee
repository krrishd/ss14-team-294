# An individual page for an It

app.controller 'ItemCtrl', ['$window', '$scope', '$routeParams', 'city', 'cityObject','cityId', ($window, $scope, $routeParams, City, cityObject, cityId) ->
 
  # Grab a reference to the item
  itemName = $routeParams.itemName
  item = new cityObject itemName

  # Give the scope access to the item
  $scope.item = item

  # Retrieve the current city
  city = new City cityId

  # A hypothetical city with the item purchased
  hypoCity = new City cityId
  hypoCity.addItem item 

  # Set a bar chart to the city's GDP contigent on 
  # purchase decision
  $scope.gdpComparison =
    labels: ['Decade', '20 years', '50 years', 'Century']
    datasets: [
      { fillColor: '#7779Ed'
      strokeColor: '#4A4DF0'
      pointColor: '#29068A'
      pointStrokeColor: '#1D0169'
      data: ([10, 20, 50, 100].map (n) -> city.getGdp n), }
      ,
      { fillColor: '#1CC414'
      strokeColor: '#129C0B' 
      pointColor: '#0B5C06'
      pointStrokeColor: '#084205'
      data: ([10, 20, 50, 100].map (n) -> hypoCity.getGdp) }
    ]


  
  # A function to purchase items
  $scope.purchaseItem = ->
    city.addItem item
    city.save()

  $scope.city = city
  $window.city = city
]
