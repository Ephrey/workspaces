const mongoose = require('mongoose');
const debug = require('debug');
const genres = require('./routes/genres');
const customers = require('./routes/customers');
const express = require('express');
const app = express();

mongoose.connect('mongodb://localhost/vidly', {useNewUrlParser: true, useUnifiedTopology: true})
    .then(() => debug('Connected to Server ...'))
    .catch((ex) => debug(ex.message));

/**
 * @type {Middleware}
 */
app.use(express.json());
app.use('/api/genres', genres);
app.use('/api/customers', customers);


/**
 * @const {(String|Number)} PORT
 */
const PORT = process.env.PORT || 3000;

/**
 * Listen for an HTTP request
 * 
 * @listens
 */
app.listen(PORT, () => console.log('Listening on port ' + PORT));
