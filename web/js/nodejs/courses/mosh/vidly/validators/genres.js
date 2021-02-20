const Joi = require("joi");

/**
 * Request Body Values Validator
 *
 * @param {Object} genre - the genre object to be validate
 * @param {Number} genre.id - the id of the genre
 * @param {Number} genre.name - the name of the genre
 *
 * @returns {Joi.ValidationOptions}
 */
function validateGenre(genre) {
  const schema = Joi.object({
    name: Joi.string().min(2).max(50).required(),
  });

  return schema.validate(genre);
}

module.exports = validateGenre;
