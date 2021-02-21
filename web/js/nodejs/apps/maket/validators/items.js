const Joi = require("joi");
const itemConst = require("../utils/constants/items");

module.exports = function (item) {
  const schema = Joi.object({
    name: Joi.string()
      .min(itemConst.MIN_LENGTH)
      .max(itemConst.MAX_LENGTH)
      .required(),
    category: Joi.string().min(itemConst.MIN_LENGTH).max(itemConst.MAX_LENGTH),
  });

  return schema.validate(item);
};
