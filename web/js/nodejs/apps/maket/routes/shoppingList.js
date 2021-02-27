const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/httpResponseCodes");
const debug = require("debug")("maket");
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
  const { error } = validateShoppingList(req.body);
  if (error) return res.status(BAD_REQUEST).send("Invalid Shopping List");

  res.send({});
});

module.exports = router;
