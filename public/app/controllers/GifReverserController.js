app.controller('GifReverserController', ['$scope', 'GifReverserService', function($scope, GifReverserService) {
    var vm = this;

    // status info
    $scope.status = {
        inProgess: false,
        errorMessage: false,
        successfulReverse: false
    };

    // gif url, set to url of source gif to show to user
    $scope.gifReversedUrl = false;

    vm.init = function() {
        // init controller here
    };

    $scope.reverseGif = function(gifSourceUrl) {
        $scope.status.inProgress = true;
    	var params = {
    		gif_url: gifSourceUrl
    	};

    	GifReverserService.reverseGif(params, function(result){
            // set new status info after successful complete
            $scope.status.errorMessage = false;
            $scope.status.inProgress = false;
            $scope.status.successfulReverse = true;

            // show the url
            $scope.gifReversedUrl = result.url;
    	}, function(error) {	
            $scope.status.inProgress = false;
    		if (error && error.data && error.data.message) {
                $scope.status.errorMessage = error.data.message;
            }
    	});
    };

    vm.init();
}]);