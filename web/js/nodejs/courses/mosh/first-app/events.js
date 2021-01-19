const EventEmitter = require('events');

class MyEvent extends EventEmitter {}

const myEvent = new MyEvent();

const eventName = 'msg';

const listener = (msg) => {
    console.log(msg.id);
}

myEvent.on(eventName, listener);
myEvent.emit(eventName, {id: 1, 'msg': 'Wait, sending ...'});