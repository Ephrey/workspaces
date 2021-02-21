const mongoose = require("mongoose");

const ItemModel = mongoose.model(
  "Items",
  new mongoose.Schema({
    name: {
      type: String,
      minlength: 2,
      maxlength: 50,
      required: true,
    },
    category: {
      type: String,
      minlength: 2,
      maxlength: 50,
      default: "other",
    },
    createDate: {
      type: Date,
      default: new Date(),
    },
  })
);

module.exports = ItemModel;
