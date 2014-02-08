app.config(function($routeProvider, $locationProvider) {
	$routeProvider.when('/register', {
		templateUrl: "angular-templates/register.html",
		controller: RegisterCtrl
	});
});
