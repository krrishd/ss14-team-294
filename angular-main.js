// Author: Ari Falkner
// James, I literally learned Angular last night so please forgive any mistakes


// Initialize a module for filters in the main module
 var filters = angular.module('app.filters', []);

// Initialize a module for services in the main module
var services = angular.module('app.services', []);

// Initialize a module for directives in the main module
var directives = angular.module('app.directives', []);

// Initialize our main app module
var app = angular.module('app', ['angles', 'ngRoute', 'ngResource', 'app.filters', 'app.services', 'app.directives']);
