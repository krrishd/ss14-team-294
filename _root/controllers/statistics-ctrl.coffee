app.controller 'StatisticsCtrl', ['$resource', '$window', '$scope', 'city', 'cityId', ($resource, $window, $scope, City, cityId) ->
  city = new City cityId

  $scope.city = city
  
  updateBalance = ->
    $scope.balance = city.getBalance()
    $scope.$apply()

  setInterval(updateBalance, 1000)

  updateAge = ->
    $scope.age= city.getAge()
    $scope.$apply()

  setInterval(updateAge, 1000)


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

   $scope.itemChart =
     [
       {
         value: 4,
         color: "#d64343",
         label: "Hello"
       }
     ]

   itemCounts = []
   addToCount = (item) ->
   
     items = city.assets.objects.filter (element) ->
   
    
      return item.name == element.info.name
    
     itemCounts.push {name: item.name, count: items.length}
   
   
   $resource('./content/marketplace.json').get (data) ->
    addToCount item for item in data.content 

   $scope.itemCounts = itemCounts

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
