// Author: Ari Falkner
// James, I literally learned Angular last night so please forgive any mistakes
<<<<<<< HEAD

// Initialize a module for filters in the main module
angular.module('app.filters', []);

// Initialize a module for services in the main module
angular.module('app.services', []);

// Initialize a module for directives in the main module
angular.module('app.directives', []);

// Initialize our main app module
var app = angular.module('app', ['ngRoute', 'app.filters', 'app.services', 'app.directives']);


=======
// Initialize a module for filters in the main module
angular.module('app.filters', []);
// Initialize a module for services in the main module
angular.module('app.services', []);
// Initialize a module for directives in the main module
angular.module('app.directives', []);
// Initialize our main app module
var app = angular.module('app', ['ngRoute', 'app.filters', 'app.services', 'app.directives']);

// View Controllers
function dashCtrl($scope) {

}

function registerCtrl($scope) {

}

function marketCtrl($scope) {

}

function statCtrl($scope) {

}

function loanCtrl($scope) {

}

function questCtrl($scope) {

}
>>>>>>> d2bb951917b77a0bd43cd7d8107081c6e9a90f49
