const {
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
  SHOPPING_LIST_MIN_BUDGET,
  SHOPPING_LIST_MAX_BUDGET,
} = require("../utils/constants/shoppingList");
const {
  ITEM_MIN_LENGTH,
  ITEM_MAX_LENGTH,
  ITEM_CATEGORY_MIN_LENGTH,
  ITEM_CATEGORY_MAX_LENGTH,
  ITEM_PRICE_MIN,
  ITEM_PRICE_MAX,
  ITEM_DEFAULT_QUANTITY,
} = require("../utils/constants/items");
const TimeFactory = require("../utils/time/time");
const mongoose = require("mongoose");

const shoppingListItemSchema = new mongoose.Schema(
  {
    id: {
      type: mongoose.Types.ObjectId,
      required: false,
    },
    name: {
      type: String,
      minlength: ITEM_MIN_LENGTH,
      maxlength: ITEM_MAX_LENGTH,
      required: true,
      trim: true,
    },
    category: {
      type: String,
      minlength: ITEM_CATEGORY_MIN_LENGTH,
      maxlength: ITEM_CATEGORY_MAX_LENGTH,
      default: "other",
      trim: true,
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
    quantity: {
      type: Number,
      min: ITEM_DEFAULT_QUANTITY,
      required: true,
    },
  },
  { strictQuery: true, _id: false }
);

const shoppingListSchema = new mongoose.Schema(
  {
    owner: {
      type: mongoose.Types.ObjectId,
      required: true,
    },
    name: {
      type: String,
      default: "Shopping List",
      required: true,
      minlength: SHOPPING_LIST_NAME_MIN_LENGTH,
      maxlength: SHOPPING_LIST_NAME_MAX_LENGTH,
      trim: true,
    },
    items: {
      type: [shoppingListItemSchema],
      required: true,
      default: [],
    },
    description: {
      type: String,
      minlength: SHOPPING_LIST_DESCRIPTION_MIN_LENGTH,
      maxlength: SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
      default: "",
      trim: true,
    },
    budget: {
      type: Number,
      min: SHOPPING_LIST_MIN_BUDGET,
      max: SHOPPING_LIST_MAX_BUDGET,
      required: true,
      trim: true,
    },
    createdDate: {
      type: Date,
      default: TimeFactory.uctDate(),
    },
  },
  { strictQuery: true }
);

module.exports = mongoose.model("ShoppingList", shoppingListSchema);
