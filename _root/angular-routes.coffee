# The routes for the angular app
# Author: Ari Falkner

# The routes for our angular app

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/', 
    templateUrl: './angular-templates/home.html'
  $routeProvider.when '/register', 
    templateUrl: './angular-templates/register.html',
    controller: 'RegisterCtrl'
]
