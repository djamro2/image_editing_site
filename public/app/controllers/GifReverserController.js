app.controller('GifReverserController', ['$scope', 'GifReverserService', function($scope, GifReverserService) {
    var vm = this;

    vm.init = function() {
        // init controller here
    };

    $scope.reverseGif = function(gifUrl) {
    	var params = {
    		gif_url: gifUrl
    	};

    	GifReverserService.reverseGif(params, function(result){
    		console.log(result);
    	}, function(error) {	
    		console.error(error);
    	});
    };

    vm.init();
}]);