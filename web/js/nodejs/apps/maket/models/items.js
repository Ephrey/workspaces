const {
  ITEM_MIN_LENGTH,
  ITEM_MAX_LENGTH,
  ITEM_CATEGORY_MIN_LENGTH,
  ITEM_CATEGORY_MAX_LENGTH,
} = require("../utils/constants/items");
const TimeFactory = require("../utils/time/time");
const mongoose = require("mongoose");

const ItemModel = mongoose.model(
  "Items",
  new mongoose.Schema(
    {
      owner: {
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
      createDate: {
        type: Date,
        default: TimeFactory.uctDate(),
      },
    },
    { strictQuery: true }
  )
);

module.exports = ItemModel;
