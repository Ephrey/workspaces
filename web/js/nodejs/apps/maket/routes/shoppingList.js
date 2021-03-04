const {
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/httpResponseCodes");
const debug = require("debug")("maket:shop_list_route");
const validateId = require("../middlewares/validateId");
const validateShoppingList = require("../validators/shoppingList");
const ShoppingListModel = require("../models/shoppingList");
const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  res.send(await ShoppingListModel.find({}));
});

router.get("/:id", validateId, async (req, res) => {
  const shoppingList = await ShoppingListModel.findById(req.params.id);

  !shoppingList
    ? res.status(NOT_FOUND).send("Shopping List not found")
    : res.send(shoppingList);
});

router.post("/", async (req, res) => {
  const shoppingListValues = req.body;

  const { error } = validateShoppingList(shoppingListValues);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const shoppingList = new ShoppingListModel(shoppingListValues);

  res.send(await shoppingList.save());
});

router.put("/:id", validateId, async (req, res) => {
  const newShoppingListValues = req.body;

  const { error } = validateShoppingList(newShoppingListValues);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const newShoppingList = await ShoppingListModel.findByIdAndUpdate(
    req.params.id,
    newShoppingListValues,
    { new: true, useFindAndModify: false }
  );

  !newShoppingList
    ? res.status(NOT_FOUND).send("Can't update. Shopping List not found")
    : res.send(newShoppingList);
});

router.put("/:id/item/:itemId", validateId, async (req, res) => {
  const shoppingList = await ShoppingListModel.exists({ _id: req.params.id });

  if (!shoppingList)
    return res.status(NOT_FOUND).send("Shopping List not found");

  shoppingListItem = await ShoppingListModel.findOne({
    "items._id": req.params.itemId,
  });

  debug(shoppingListItem);
  res.send(req.query);
});

router.delete("/:id", validateId, async (req, res) => {
  const deletedShoppingList = await ShoppingListModel.findByIdAndDelete(
    req.params.id
  );

  !deletedShoppingList
    ? res.status(NOT_FOUND).send("Shopping List not found")
    : res.send(deletedShoppingList);
});

module.exports = router;
