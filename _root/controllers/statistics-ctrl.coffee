app.controller 'StatisticsCtrl', ['$resource', '$window', '$scope', 'city', 'cityId', ($resource, $window, $scope, City, cityId) ->
  city = new City cityId

  $scope.city = city
  
  updateGdp = ->
    $scope.GDP = city.getGdpCurrent()
    $scope.$apply()

  updateGdp()
  setInterval(updateGdp, 1000)

  updateBalance = ->
    $scope.balance = city.getBalance()
    $scope.$apply()

  updateBalance()
  setInterval(updateBalance, 1000)

  updateAge = ->
    $scope.age= city.getAge()
    $scope.$apply()

  updateAge()
  setInterval(updateAge, 1000)

  $scope.years = 0

  $window.city = city
  gdpArray = ([10, 20, 50, 100].map (n) -> city.getGdp n)

  $scope.gdpGrowth =
    labels: ['Decade', '20 years', '50 years', 'Century']
    datasets: [
      { fillColor: '#7779Ed'
      strokeColor: '#4A4DF0'
      pointColor: '#29068A'
      pointStrokeColor: '#1D0169'
      data: gdpArray } 
    ]


   itemCounts = []
   addToCount = (item) ->
   
     items = city.assets.objects.filter (element) ->
   
    
      return item.name == element.info.name
    
     itemCounts.push {name: item.name, count: items.length}
   
   
   $resource('./content/marketplace.json').get (data) ->
     addToCount item for item in data.content 

     $scope.itemCounts = itemCounts

     itemLabels = itemCounts.map (i) ->
       return i.name

     itemNumbers = itemCounts.map (i) ->
       return i.count

     $scope.itemChart=
       labels: itemLabels, 
       datasets: [
         { fillColor: '#7779Ed'
         strokeColor: '#4A4DF0'
         pointColor: '#29068A'
         pointStrokeColor: '#1D0169'
         data: itemNumbers } 
       ]

     $scope.$apply()
]

filters.filter 'gdp', ->
  (input, city) ->
    return city.getGdp input

filters.filter 'balance', ->
  (input, city) ->
    return city.getBalancePredicted input

filters.filter 'total', ->
  (input, city) ->
    return city.getTotal input
