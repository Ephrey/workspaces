const {
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
  SHOPPING_LIST_MIN_ITEMS,
  SHOPPING_LIST_MIN_BUDGET,
  SHOPPING_LIST_MAX_BUDGET,
} = require("../utils/constants/shoppingList");
const { ITEM_PRICE_MIN, ITEM_PRICE_MAX } = require("../utils/constants/items");
const debug = require("debug")("maket:shop_list_validator");
const Joi = require("joi");

const validateShoppingList = (shoppingList) => {
  const schema = Joi.object({
    name: Joi.string()
      .min(SHOPPING_LIST_NAME_MIN_LENGTH)
      .max(SHOPPING_LIST_NAME_MAX_LENGTH)
      .trim()
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
          quantity: Joi.number().required().default(),
        })
      )
      .min(SHOPPING_LIST_MIN_ITEMS)
      .required(),
    description: Joi.string()
      .min(SHOPPING_LIST_DESCRIPTION_MIN_LENGTH)
      .max(SHOPPING_LIST_DESCRIPTION_MAX_LENGTH)
      .trim()
      .allow("")
      .required(),
    budget: Joi.number()
      .min(SHOPPING_LIST_MIN_BUDGET)
      .max(SHOPPING_LIST_MAX_BUDGET)
      .required(),
  });

  return schema.validate(shoppingList);
};

const validateShoppingListItemNewValues = (newValues) => {
  const schema = Joi.object({
    price: Joi.number().min(ITEM_PRICE_MIN).max(ITEM_PRICE_MAX).required(),
    bought: Joi.boolean().required(),
  });

  return schema.validate(newValues);
};

module.exports = { validateShoppingList, validateShoppingListItemNewValues };
