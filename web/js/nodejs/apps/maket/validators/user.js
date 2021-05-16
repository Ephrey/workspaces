const {
  USER_NAME_MIN_LENGTH,
  USER_NAME_MAX_LENGTH,
  USER_EMAIL_MIN_LENGTH,
  USER_EMAIL_MAX_LENGTH,
  USER_PASSWORD_MIN_LENGTH,
  USER_PASSWORD_MAX_LENGTH,
} = require("../utils/constants/user");
const Joi = require("joi");

const userRegisterValidate = (user) => {
  const schema = Joi.object({
    name: Joi.string()
      .min(USER_NAME_MIN_LENGTH)
      .max(USER_NAME_MAX_LENGTH)
      .required(),
    email: Joi.string().email().required(),
    password: Joi.string()
      .min(USER_PASSWORD_MIN_LENGTH)
      .max(USER_PASSWORD_MAX_LENGTH)
      .required(),
  });

  return validate(schema, user);
};

const userLoginValidate = (user) => {
  const schema = Joi.object({
    email: Joi.string()
      .min(USER_EMAIL_MIN_LENGTH)
      .max(USER_EMAIL_MAX_LENGTH)
      .email()
      .required(),
    password: Joi.string()
      .min(USER_PASSWORD_MIN_LENGTH)
      .max(USER_PASSWORD_MAX_LENGTH)
      .required(),
  });

  return validate(schema, user);
};

function validate(schema, user) {
  return schema.validate(user);
}

module.exports = { userRegisterValidate, userLoginValidate };
