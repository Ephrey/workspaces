const mongoose = require('mongoose');
const { genreSchema } = require('./genres');

const movieSchema = new mongoose.Schema({
    title: {
        type: String,   
        required: true,
        trim: true,
        minlength: 4,
        maxlength:50
    },
    genre: {
        type: genreSchema,
        required: true
    },
    numberInStock: {
        type: Number,
        required: true,
        min:0,
        max: 255
    },
    dailyRentalRate:  {
        type: Number,
        required: true,
        min:0,
        max: 255
    }
});


const MovieModel = mongoose.model('Movies', movieSchema);

module.exports = MovieModel;