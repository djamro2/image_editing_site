
app.factory('GifReverserService', function($resource){
    return $resource('http://54.173.206.30:3009/gif_reverser', null, {
        reverseGif: {
            method: 'POST',
            url: 'http://54.173.206.30:3009/gif_reverser',
            headers: {"Access-Control-Allow-Origin": "true"},
            isArray: false
        }
    });
});