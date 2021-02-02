const Joi = require('joi');

module.exports = function validateMovie(movie) {
    const schema = Joi.object({
        title: Joi.string().min(4).max(50).required(),
        genreId: Joi.objectId().required(),
        numberInStock: Joi.number().min(0).required(),
        dailyRentalRate: Joi.number().min(0).required(),
    });

    return schema.validate(movie);
}