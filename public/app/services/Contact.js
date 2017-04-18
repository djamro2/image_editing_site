
app.factory('ContactService', function($resource){
    return $resource('/api/contact', null, {
        sendContactInfo: {
            method: 'POST',
            url: 'https://hn9w3o1wnf.execute-api.us-east-1.amazonaws.com/development/contact',
            headers: {"Access-Control-Allow-Origin": "true"} 
        }
    });
});