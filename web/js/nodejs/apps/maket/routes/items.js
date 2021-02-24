const debug = require("debug")("maket");
const validateId = require("../middlewares/validateId");
const { BAD_REQUEST, NOT_FOUND } = require("../utils/constants/response_codes");
const ItemModel = require("../models/items");
const validateItem = require("../validators/items");
const mongoose = require("mongoose");
const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  res.send(await ItemModel.find({}));
});

router.get("/:id", validateId, async (req, res) => {
  const item = await ItemModel.findOne({ _id: req.params.id });
  !item ? res.status(NOT_FOUND).send("Item not found") : res.send(item);
});

router.post("/", async (req, res) => {
  const { error } = validateItem(req.body);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const item = new ItemModel(req.body);
  res.send(await item.save());
});

router.put("/:id", validateId, async (req, res) => {
  const itemId = req.params.id;
  const newValues = req.body;

  const { error } = validateItem(newValues);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const newItem = await ItemModel.findByIdAndUpdate(itemId, newValues, {
    new: true,
  });

  !newItem
    ? res.status(NOT_FOUND).send("Item not found for the given ID")
    : res.send(newItem);
});

router.delete("/:id", validateId, async (req, res) => {
  const deletedItem = await ItemModel.findOneAndDelete({ _id: req.params.id });

  !deletedItem
    ? res.status(NOT_FOUND).send("Item not found")
    : res.send(deletedItem);
});

module.exports = router;
