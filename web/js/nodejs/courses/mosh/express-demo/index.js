const startupDebugger = require('debug')('app:startup');
const config    = require('config');
const helmet    = require('helmet');
const morgan    = require('morgan');
const logger    = require('./middlewares/logger');
const auth      = require('./middlewares/auth');
const home      = require('./routes/home');
const courses   = require('./routes/courses');
const express   = require('express');
const app       = express();

// template engine
app.set('view engine', 'pug');
app.set('views', './views'); // default

// console.log(`NODE_ENV : ${process.env.NODE_ENV}`);
console.log(`app: ${app.get('env')}`)

// builtin middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// third party middlewares
app.use(helmet())

app.use('/', home);
app.use('/api/courses', courses);

// configurations 
console.log('Application Name: ' + config.get('name'));
console.log('Mail Server : ' + config.get('mail.host'));
console.log('Mail Password : ' + config.get('mail.password'));

if(app.get('env') === 'development') {
    app.use(morgan('tiny'));
    startupDebugger('morgan enable');
}

app.use(logger)
app.use(auth);

// PORT 
const port = process.env.PORT || 3000;
app.listen(port, () => console.log('Listening on port ' + port));