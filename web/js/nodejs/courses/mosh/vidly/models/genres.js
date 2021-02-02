const mongoose = require('mongoose');

const genreSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        minlength: 2,
        maxlength: 50,
        trim: true
    }
});

const GenreModel = mongoose.model('Genre', genreSchema);

module.exports.GenreModel = GenreModel;
module.exports.genreSchema = genreSchema;
