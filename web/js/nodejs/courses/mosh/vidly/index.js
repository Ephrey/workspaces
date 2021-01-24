const genres = require('./routes/genres');
const express = require('express');
const app = express();

/**
 * @type {Middleware}
 */
app.use(express.json());
app.use('/api/genres', genres);


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
