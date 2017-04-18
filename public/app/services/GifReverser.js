
app.factory('GifReverserService', function($resource){
    return $resource('/gif_reverser', null, {
        reverseGif: {
            method: 'POST',
            url: '/gif_reverser',
            isArray: false
        }
    });
});