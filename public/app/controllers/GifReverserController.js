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
        reversedGifId = vm.getParameterByName('id')
        if (reversedGifId && reversedGifId !== '') {
            $scope.gifReversedUrl = vm.getGifReversedUrl(reversedGifId)
        }
    };

    /**
     * Return the reversed url of gif, given an id
     */
    vm.getGifReversedUrl = function(gif_id) {
        // assuming file extension for now (use database later)
        return "https://s3.amazonaws.com/image-editor-site/reversed_gifs/" + gif_id + "_reversed.gif";
    };

    /**
     * Get a parameter value by name
     * http://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
     */
    vm.getParameterByName = function(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)");
        var results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
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