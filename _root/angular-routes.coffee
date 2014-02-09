# The routes for the angular app
# Author: Ari Falkner

# The routes for our angular app

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/register',
    templateUrl: './angular-templates/register.html',
    controller: 'RegisterCtrl'

  $routeProvider.when '/', 
    templateUrl: './angular-templates/home.html' 

  # Dashboard routes
  $routeProvider.when "/dashboard",
	   templateUrl: "/dashboard-components/marketplace.html"
	  

  $routeProvider.when "/dashboard/marketplace/:item",
    templateUrl: "./dashboard-components/item.html",
    controller: "ItemCtrl"

  $routeProvider.when "/dashboard/marketplace",
	   templateUrl: "/dashboard-components/marketplace.html"
	 

  $routeProvider.when "/dashboard/statistics",
	   templateUrl: "/dashboard-components/statistics.html"
	

  $routeProvider.when "/dashboard/loans",
	   templateUrl: "/dashboard-components/loans.html"


  $routeProvider.when "/dashboard/quests",
	   templateUrl: "/dashboard-components/quests.html"

  $routeProvider.when "/dashboard/item",
     templateUrl: "/dashboard-components/item.html"
]
