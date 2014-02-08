app.config(function($routeProvider, $locationProvider) {
	$routeProvider.when('/register', {
		templateUrl: "angular-templates/register.html",
		controller: registerCtrl
	});
	// Dashboard routes
	$routeProvider.when('/dashboard', {
		templateUrl: "/dashboard-components/marketplace.html",
		controller: dashCtrl
	});
	$routeProvider.when('/dashboard/marketplace', {
		templateUrl: "/dashboard-components/marketplace.html",
		controller: marketCtrl
	});
	$routeProvider.when('/dashboard/statistics', {
		templateUrl: "/dashboard-components/statistics.html",
		controller: statCtrl
	});
	$routeProvider.when('/dashboard/loans', {
		templateUrl: "/dashboard-components/loans.html",
		controller: loanCtrl
	});
	$routeProvider.when('/dashboard/quests', {
		templateUrl: "/dashboard-components/quests.html",
		controller: questCtrl
	});
	$locationProvider.html5Mode(true);
});
