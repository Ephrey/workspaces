const {
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
  SHOPPING_LIST_MIN_ITEMS,
  SHOPPING_LIST_MIN_BUDGET,
  SHOPPING_LIST_MAX_BUDGET,
} = require("../utils/constants/shoppingList");
const {
  ITEM_PRICE_MIN,
  ITEM_PRICE_MAX,
  ITEM_MIN_LENGTH,
  ITEM_MAX_LENGTH,
  ITEM_CATEGORY_MIN_LENGTH,
  ITEM_CATEGORY_MAX_LENGTH,
  ITEM_DEFAULT_QUANTITY,
  ITEM_MAX_QUANTITY,
} = require("../utils/constants/items");
const debug = require("debug")("maket:shop_list_validator");
const Joi = require("joi");

const validateShoppingList = (shoppingList) => {
  const schema = Joi.object({
    owner: Joi.objectId().required(),
    name: Joi.string()
      .min(SHOPPING_LIST_NAME_MIN_LENGTH)
      .max(SHOPPING_LIST_NAME_MAX_LENGTH)
      .trim()
      .required(),
    items: Joi.array()
      .items(
        Joi.object({
          id: Joi.objectId().required(),
          name: Joi.string()
            .min(ITEM_MIN_LENGTH)
            .max(ITEM_MAX_LENGTH)
            .required(),
          category: Joi.string()
            .min(ITEM_CATEGORY_MIN_LENGTH)
            .max(ITEM_CATEGORY_MAX_LENGTH)
            .required(),
          price: Joi.number()
            .min(ITEM_PRICE_MIN)
            .max(ITEM_PRICE_MAX)
            .required(),
          bought: Joi.boolean().required(),
          quantity: Joi.number().required(),
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
    quantity: Joi.number()
      .min(ITEM_DEFAULT_QUANTITY)
      .max(ITEM_MAX_QUANTITY)
      .required(),
  });

  return schema.validate(newValues);
};

module.exports = { validateShoppingList, validateShoppingListItemNewValues };
