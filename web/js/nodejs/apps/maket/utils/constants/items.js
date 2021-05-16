const { BASE_ENDPOINT } = require("../../utils/constants/common");

module.exports = Object.freeze({
  ITEM_ENDPOINT: BASE_ENDPOINT + "items/",
  ITEM_MIN_LENGTH: 2,
  ITEM_MAX_LENGTH: 50,
  ITEM_CATEGORY_MIN_LENGTH: 2,
  ITEM_CATEGORY_MAX_LENGTH: 50,
  ITEM_PRICE_MIN: 0.0,
  ITEM_PRICE_MAX: 50000.0,
  ITEM_DEFAULT_QUANTITY: 1,
});
