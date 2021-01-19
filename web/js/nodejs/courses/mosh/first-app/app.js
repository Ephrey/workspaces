const Logger = require('./logger');
const myLogger = new Logger();

// Register a listener
myLogger.on('msgLog', (arg) => {
    console.log('Listener called', arg);
})

myLogger.log('Message');