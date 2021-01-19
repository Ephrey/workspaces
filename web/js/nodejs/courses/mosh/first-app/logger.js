const EventEmitter = require('events');

var url = 'http://mylogger.io/log';

class Logger extends EventEmitter {
    log(message) {
        // Send an HTTP request
        console.log(message);

        // Raise the event
        this.emit('msgLog', {id: 1, url: 'http://'});
    }
}

module.exports = Logger;