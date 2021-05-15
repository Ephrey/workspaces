const {
  USER_NAME_MIN_LENGTH,
  USER_NAME_MAX_LENGTH,
  PASSWORD_MIN_LENGTH,
} = require("../utils/constants/user");
const Joi = require("joi");

module.exports = (user) => {
  const schema = Joi.object({
    name: Joi.string()
      .min(USER_NAME_MIN_LENGTH)
      .max(USER_NAME_MAX_LENGTH)
      .required(),
    email: Joi.string().email().required(),
    password: Joi.string().min(PASSWORD_MIN_LENGTH).required(),
  });

  return schema.validate(user);
};
