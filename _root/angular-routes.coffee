# The routes for the angular app
# Author: Ari Falkner

# The routes for our angular app

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/register',
    templateUrl: './angular-templates/register.html', controller: 'RegisterCtrl'

  $routeProvider.when '/', 
    templateUrl: './angular-templates/home.html' 

  # Dashboard routes

  $routeProvider.when "/dashboard",
	  templateUrl: "/dashboard-components/marketplace.html", controller: "MarketCtrl"
	  

  $routeProvider.when "/dashboard/marketplace/:itemName",
    templateUrl: "./dashboard-components/item.html", controller: "ItemCtrl", title: 'Item'

  $routeProvider.when "/dashboard/marketplace",
	  templateUrl: "/dashboard-components/marketplace.html", controller: "MarketCtrl", title: 'Marketplace',

  $routeProvider.when "/dashboard/statistics",
	   templateUrl: "/dashboard-components/statistics.html", controller: "StatisticsCtrl"

  $routeProvider.when "/dashboard/loans",
	   templateUrl: "/dashboard-components/loans.html", title: 'Loans'

  $routeProvider.when "/dashboard/quests",
	   templateUrl: "/dashboard-components/quests.html", title: 'Quests'

]
