'use strict';

app.directive('navbar', function($window){
    return {
        restrict: 'AE',
        templateUrl: '/app/views/navbar.html',
        link: function(scope, element, attrs) {

            // go to the about page url
            scope.goToAbout = function() {
                $window.location.href = '/#';
            };

            // go to the home url
            scope.goToHome = function() {
                $window.location.href = '/';
            }

        }
    };
});

