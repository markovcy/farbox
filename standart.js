const http = require('http');
const fs = require('fs');


// http.createServer().listen(3000);
http.createServer(function (request, response) {
    console.log(request.url);
    console.log(request.method);
    // console.log(request.headers('user-agent'));
    console.log(request.headers['user-agent']);

    response.setHeader("Content-Type", "text/html; charset=utf-8;")

    if (request.url == '/') {
        response.end('Main <b>hello</b> Привет мир');
    }
    else if (request.url == '/cat') {
        response.end('Category <h2>Hello</h2> Привет мир');
    }
    else if (request.url == '/dat') {
        let myFile = fs.readFileSync('1.dat');
        console.log(myFile);
        response.end(myFile);
    }
}).listen(3000);