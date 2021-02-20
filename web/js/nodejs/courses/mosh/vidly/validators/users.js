const Joi = require("joi");

const MIN = 5;
const DEFAULT_MAX = 55;

module.exports = function validateUser(user) {
  const schema = Joi.object({
    name: Joi.string().min(MIN).max(DEFAULT_MAX).required(),
    email: Joi.string()
      .min(MIN)
      .max(DEFAULT_MAX + 200)
      .email(),
    password: Joi.string()
      .min(MIN)
      .max(DEFAULT_MAX + 200),
  });

  return schema.validate(user);
};
