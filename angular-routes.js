app.config([
  '$routeProvider', function($routeProvider) {
    $routeProvider.when('/', {
      templateUrl: './angular-templates/home.html'
    });
    $routeProvider.when('/register', {
      templateUrl: './angular-templates/register.html',
      controller: 'RegisterCtrl'
    });
    $routeProvider.when("/dashboard", {
      templateUrl: "/dashboard-components/marketplace.html"
    });
    $routeProvider.when("/dashboard/marketplace", {
      templateUrl: "/dashboard-components/marketplace.html"
    });
    $routeProvider.when("/dashboard/statistics", {
      templateUrl: "/dashboard-components/statistics.html"
    });
    $routeProvider.when("/dashboard/loans", {
      templateUrl: "/dashboard-components/loans.html"
    });
    $routeProvider.when("/dashboard/quests", {
      templateUrl: "/dashboard-components/quests.html"
    });
    return $routeProvider.when("/dashboard/item", {
      templateUrl: "/dashboard-components/item.html"
    });
  }
]);
