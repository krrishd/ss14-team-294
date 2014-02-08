// Author: Ari Falkner
// James, I literally learned Angular last night so please forgive any mistakes
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
