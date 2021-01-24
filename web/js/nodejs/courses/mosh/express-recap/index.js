const debug = require('debug')('app:recap')
const config = require('config');
const morgan = require('morgan');
const logger = require('./middlewares/logger');
const helmet = require('helmet');
const express = require('express');
const app = express();

app.set('view engine', 'pug');

app.use(express.json());
app.use(morgan('tiny'));
app.use(helmet());
app.use(express.static('public'));
app.use(express.urlencoded({extended: true}));


if(app.get('env') === 'development') {
    app.use(logger);
}

debug(app.get('env'));
debug(config.get('name'));
debug(config.get('email.host'));
debug(config.get('email.password'));

const friends = [
    {id: 1, name: 'Kaddy'},
    {id: 2, name: 'Raymond'},
    {id: 3, name: 'Prince'}
];

app.get('/', (req, res) => {
    debug(req.query.msg);
    res.render('index', {title: 'Express App', message: req.query.msg});
});

app.get('/api/friends', (req, res) => {
    res.send(friends);
});

app.post('/api/friends', (req, res) => {
    res.send(req.body);
});


const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log('Listening on port ' + PORT));