var http = require('http');
const request = require("request");
const cheerio = require('cheerio');
var output = ""
var objs = ''
var values = ''
var reverse_mess = ""
var count = 0

request('http://signavioapp.com', function (error, response, json) {
    if (!error && response.statusCode == 200) {
        output = cheerio.load(json);
        objs = JSON.parse(output.text())
        for (var i in objs){
           count = count + 1
           if ( count == 2){
               values = objs[i]
           } 
        }      
        reverse_mess = reverseString(values);
    }
});

function reverseString(str) {
    var newString = "";
    for (var i = str.length - 1; i >= 0; i--) {
        newString += str[i];
    }
    return newString;
}

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end(reverse_mess);
  }).listen(9091);

