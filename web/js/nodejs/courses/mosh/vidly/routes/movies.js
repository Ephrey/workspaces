const auth = require('../middlewares/auth');
const MovieModel = require('../models/movies');
const { GenreModel } = require('../models/genres');
const validateMovie = require('../validators/movies');
const express = require('express');
const router = express.Router();


/**
 * POST : Create a Movie
 */
 router.post('/', auth, async (req, res) => {
    let movie = req.body;

    const { error } = validateMovie(movie);

    if(error) {
        return res.status(400).send(error.details[0].message);
    }

    try {
        const genre = await GenreModel.findById(movie.genreId);

        if(!genre) {
            return res.status(400).send('The genre with the given ID does not exist');
        }

        movie = new MovieModel({
            title: movie.title,
            genre: {
                _id: genre.id,
                name: genre.name
            },
            numberInStock: movie.numberInStock,
            dailyRentalRate: movie.dailyRentalRate
        }); 

        res.send(await movie.save());

    } catch (err) {
        res.send(err.message);
    }
 });


 module.exports = router;