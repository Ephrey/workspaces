const {
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
} = require("../utils/constants/shoppingList");
const { ITEM_PRICE_MIN, ITEM_PRICE_MAX } = require("../utils/constants/items");
const mongoose = require("mongoose");

const shoppingListItemSchema = new mongoose.Schema({
  _id: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
  price: {
    type: Number,
    min: ITEM_PRICE_MIN,
    max: ITEM_PRICE_MAX,
    required: true,
  },
  bought: {
    type: Boolean,
    default: false,
  },
});

const shoppingListSchema = new mongoose.Schema({
  name: {
    type: String,
    default: "Shopping List",
    minlength: SHOPPING_LIST_NAME_MIN_LENGTH,
    maxlength: SHOPPING_LIST_NAME_MAX_LENGTH,
    trim: true,
  },
  items: {
    type: [shoppingListItemSchema],
    required: true,
  },
  description: {
    type: String,
    minlength: SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
    maxlength: SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
    default: "",
    trim: true,
  },
  createdDate: {
    type: Date,
    default: new Date(),
  },
});

module.exports = mongoose.model("ShoppingList", shoppingListSchema);
