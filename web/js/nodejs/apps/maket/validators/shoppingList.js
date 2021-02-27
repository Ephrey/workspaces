const {
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
} = require("../utils/constants/shoppingList");
const { ITEM_PRICE_MIN, ITEM_PRICE_MAX } = require("../utils/constants/items");
const Joi = require("joi");

module.exports = (shoppingList) => {
  const schema = Joi.object({
    name: Joi.string()
      .min(SHOPPING_LIST_NAME_MIN_LENGTH)
      .max(SHOPPING_LIST_NAME_MAX_LENGTH)
      .required(),
    items: Joi.array()
      .items(
        Joi.object({
          _id: Joi.objectId().required(),
          price: Joi.number()
            .min(ITEM_PRICE_MIN)
            .max(ITEM_PRICE_MAX)
            .required(),
          bought: Joi.boolean().required(),
        })
      )
      .required(),
    description: Joi.string()
      .min(SHOPPING_LIST_DESCRIPTION_MIN_LENGTH)
      .max(SHOPPING_LIST_DESCRIPTION_MAX_LENGTH),
  });

  return schema.validate(shoppingList);
};
