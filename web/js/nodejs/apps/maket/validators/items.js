const Joi = require("joi");
const {
  ITEM_MIN_LENGTH,
  ITEM_MAX_LENGTH,
} = require("../utils/constants/items");

module.exports = (item) => {
  const schema = Joi.object({
    owner: Joi.objectId().required(),
    name: Joi.string().min(ITEM_MIN_LENGTH).max(ITEM_MAX_LENGTH).required(),
    category: Joi.string().min(ITEM_MIN_LENGTH).max(ITEM_MAX_LENGTH),
  });

  return schema.validate(item);
};
