
app.controller('HomePageController', ['$scope', 'ContactService', function($scope, ContactService) {
    var vm = this;
    $scope.contactInfo = {};
    $scope.contactInfoSent = false;

    vm.init = function() {
        // init controller here
    };

    // send a PUT request with the contactInfo obj. Send email and save
    $scope.sendContactMessage = function(contactInfo) {
        ContactService.sendContactInfo(contactInfo, function(result) {
            $scope.contactInfoSent = true;
        }, function(error) {
            // nothing right now
        });
    };

    // scroll to the tools sections with jquery, element with id 'tools'
    $scope.scrollToTools = function() {
        $('html, body').animate({
            scrollTop: $("#tools").offset().top - 18
        }, 2000);
    };

    vm.init();
}]);