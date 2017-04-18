app.controller('GifReverserController', ['$scope', 'GifReverserService', function($scope, GifReverserService) {
    var vm = this;

    // status message
    $scope.errorMessage = false;
    $scope.successfulReverse = false;
    $scope.status = {
        inProgess: false
    };

    vm.init = function() {
        // init controller here
    };

    $scope.reverseGif = function(gifUrl) {
        $scope.status.inProgress = true;
    	var params = {
    		gif_url: gifUrl
    	};

    	GifReverserService.reverseGif(params, function(result){
            $scope.errorMessage = false;
            $scope.status.inProgress = false;
            $scope.successfulReverse = true;
    	}, function(error) {	
            $scope.status.inProgress = false;
    		if (error && error.data && error.data.message) {
                $scope.errorMessage = error.data.message;
            }
    	});
    };

    vm.init();
}]);