const debug = require("debug")("maket:item_route");
const validateId = require("../middlewares/validateId");
const {
  BAD_REQUEST,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
} = require("../utils/constants/httpResponseCodes");
const ItemModel = require("../models/items");
const ShoppingListModel = require("../models/shoppingList");
const validateItem = require("../validators/items");
const authorization = require("../middlewares/authorization");
const mongoose = require("mongoose");
const express = require("express");
const router = express.Router();

router.use(authorization);

router.get("/", async (req, res) => {
  res.send(await ItemModel.find({}));
});

router.get("/:id", validateId, async (req, res) => {
  const item = await ItemModel.findById(req.params.id);
  !item ? res.status(NOT_FOUND).send("Item not found") : res.send(item);
});

router.post("/", async (req, res) => {
  const { error } = validateItem(req.body);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const itemExist = await ItemModel.exists({
    name: { $regex: req.body.name, $options: "i" },
    owner: req.body.owner,
  });

  if (itemExist) return res.status(BAD_REQUEST).send("Item already exists");

  const item = new ItemModel(req.body);
  res.send(await item.save());
});

router.put("/:id", validateId, async (req, res) => {
  const itemId = req.params.id;
  const newValues = req.body;

  const { error } = validateItem(newValues);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const options = { new: true, useFindAndModify: false };
  const newItem = await ItemModel.findByIdAndUpdate(itemId, newValues, options);

  !newItem
    ? res.status(NOT_FOUND).send("Item not found for the given ID")
    : res.send(newItem);
});

router.delete("/:id", validateId, async (req, res) => {
  const itemId = req.params.id;

  const itemExist = await ItemModel.exists({ _id: itemId });

  if (!itemExist) {
    return res.status(NOT_FOUND).send("Item not found");
  }

  const session = await mongoose.connection.startSession();
  session.startTransaction();

  try {
    deletedItem = await ItemModel.findByIdAndDelete(itemId, {
      session: session,
    });

    await ShoppingListModel.updateMany(
      { "items._id": itemId },
      { $pull: { items: { _id: { $eq: itemId } } } },
      { session: session }
    );

    if (req.query.throw) {
      throw new Error("Transaction failed for testing purpose ... :(");
    }

    await session.commitTransaction();
    session.endSession();

    res.send(deletedItem);
  } catch (err) {
    await session.abortTransaction();
    session.endSession();

    return res.status(INTERNAL_SERVER_ERROR).send(err.message);
  }
});

module.exports = router;
