app.controller('GifReverserController', ['$scope', 'GifReverserService', function($scope, GifReverserService) {
    var vm = this;

    // status message
    $scope.errorMessage = false;
    $scope.successfulReverse = false

    vm.init = function() {
        // init controller here
    };

    $scope.reverseGif = function(gifUrl) {
    	var params = {
    		gif_url: gifUrl
    	};

    	GifReverserService.reverseGif(params, function(result){
            $scope.errorMessage = false;
            $scope.successfulReverse = true;
    	}, function(error) {	
    		if (error && error.data && error.data.message) {
                $scope.errorMessage = error.data.message;
            }
    	});
    };

    vm.init();
}]);