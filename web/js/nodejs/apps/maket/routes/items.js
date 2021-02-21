const ItemModel = require("../models/items");
const validateItem = require("../validators/items");
const mongoose = require("mongoose");
const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  res.send(await ItemModel.find({}));
});

router.get("/:id", async (req, res) => {
  if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
    return res.status(400).send("Invalid Item ID");
  }

  const item = await ItemModel.findOne({ _id: req.params.id });

  if (!item) return res.status(404).send("Item not found");

  res.send(item);
});

router.post("/", async (req, res) => {
  const { error } = validateItem(req.body);
  if (error) return res.status(400).send(error.details[0].message);

  const item = new ItemModel(req.body);
  res.send(await item.save());
});

module.exports = router;
