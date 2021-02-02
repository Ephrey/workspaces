const auth = require('../middlewares/auth');
const validateRental = require('../validators/rentals');
const RentalModel = require('../models/rentals');
const { CustomerModel } = require('../models/customers');
const MovieModel = require('../models/movies');
const mongoose = require('mongoose');
const Fawn = require('fawn');
const express = require('express');
const router = express.Router();

Fawn.init(mongoose);

router.post('/', auth, async (req, res) => {
    let rental = req.body;

    const { error } = validateRental(rental);

    if(error) {
        return res.status(400).send(error.details[0].message);
    }

    const customer = await CustomerModel.findById(rental.customerId);

    if(!customer) {
        return res.status(400).send('The customer does not exist');
    }

    const movie = await MovieModel.findById(rental.movieId);

    if(!movie) {
        return res.status(400).send(`Movie not found`);
    }

    if(movie.numberInStock === 0) {
        return res.status(400).send('Movie not in stock');
    }


    rental = new RentalModel({
        customer: {
            _id: customer._id,
            'name': customer.name,
            'phone': customer.phone
        }, 
        movie: {
            _id: movie._id,
            'title': movie.title,
            'dailyRentalRate': movie.dailyRentalRate
        }
    });

    new Fawn.Task()
        .save('rentals', rental)
        .update('movies', { _id: movie._id }, { $inc: {numberInStock: -1 }})
        // .remove()
        .run()
        .then(() => {
            res.send(rental);
        })
        .catch(err => res.send(err));
    
});


router.get('/', async (req, res) => {
    res.send(await RentalModel.find({}).sort({dateOut: -1}));
});


module.exports = router;