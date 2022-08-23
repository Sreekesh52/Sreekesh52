var http = require('http');

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('{ "id": "1", "message": "Hello world" }');
}).listen(9090);