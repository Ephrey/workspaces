const Joi = require("joi");
const auth = require("../middlewares/auth");
const validate = require("../middlewares/validate");
const RentalModel = require("../models/rentals");
const MovieModel = require("../models/movies");
const express = require("express");
const router = express.Router();

router.post("/", [auth, validate(validateReturn)], async (req, res) => {
  const rental = await RentalModel.lookup(
    req.body.customerId,
    req.body.movieId
  );

  if (!rental) {
    return res.status(404).send("Rental not found");
  }

  if (rental.dateReturn) {
    return res.status(400).send("Rental already processed");
  }

  rental.return();
  rental.save();

  await MovieModel.updateOne(
    { _id: rental.movie._id },
    { $inc: { numberInStock: 1 } }
  );

  return res.send(rental);
});

function validateReturn(req) {
  const schema = Joi.object({
    customerId: Joi.objectId().required(),
    movieId: Joi.objectId().required(),
  });
  return schema.validate(req);
}

module.exports = router;
