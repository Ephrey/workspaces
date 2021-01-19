const http = require('http');
const s = require('./status');


const server = http.createServer((req, res) => {
    if(req.url === '/') {
        const body = JSON.stringify({"id":3939, "name": "Ephraim Ilunga"});
        const option = {'Content-Type': 'application/json'};

        res.writeHead(s.S_SUCCESS, 'Success', option).end(body);
    }

    if(req.url === '/api/courses') {
        res.write(JSON.stringify([1, 2, 3]));
        res.end();
    }
});

server.listen(5000);

console.log('Listening on port 5000');