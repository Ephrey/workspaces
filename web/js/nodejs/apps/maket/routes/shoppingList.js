const {
  BAD_REQUEST,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
} = require("../utils/constants/httpResponseCodes");
const debug = require("debug")("maket:shop_list_route");
const validateId = require("../middlewares/validateId");
const {
  validateShoppingList,
  validateShoppingListItemNewValues,
} = require("../validators/shoppingList");
const ShoppingListModel = require("../models/shoppingList");
const authorization = require("../middlewares/authorization");
const express = require("express");

const mongoose = require("mongoose");
const router = express.Router();

router.use(authorization);

router.get("/", async (req, res) => {
  res.send(
    await ShoppingListModel.find({ owner: req.body.owner }).sort("-_id")
  );
});

router.get("/body", async (req, res) => {
  const shoppingListBodies = await ShoppingListModel.aggregate([
    { $match: { owner: mongoose.Types.ObjectId(req.body.owner) } },
    {
      $project: {
        name: 1,
        itemsCount: { $size: "$items" },
        description: 1,
        budget: 1,
        createdDate: 1,
        spent: {
          $reduce: {
            input: "$items",
            initialValue: 0.0,
            in: {
              $add: [
                "$$value",
                { $multiply: ["$$this.price", "$$this.quantity"] },
              ],
            },
          },
        },
      },
    },
    { $sort: { _id: -1 } },
  ]);

  res.send(shoppingListBodies);
});

router.get("/:id/items", validateId, async (req, res) => {
  const shoppingListId = req.params.id;
  const owner = req.body.owner;

  const shoppingListItems = await ShoppingListModel.find({
    owner: owner,
    _id: shoppingListId,
  }).select("items -_id");

  res.send(shoppingListItems[0]);
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

router.put("/:id/add_items", validateId, async (req, res) => {
  const shoppingListId = req.params.id;
  const ownerId = req.body.owner;
  const items = req.body.items;

  if (items.length == 0) {
    return res.status(BAD_REQUEST).send("You must provide at least one item.");
  }

  const shoppingListExists = await ShoppingListModel.exists({
    _id: shoppingListId,
    owner: ownerId,
  });

  if (!shoppingListExists) {
    return res
      .status(BAD_REQUEST)
      .send("The Shopping List you are trying to update does not exist.");
  }

  const response = await ShoppingListModel.updateOne(
    { _id: shoppingListId, owner: ownerId },
    { $push: { items: { $each: items } } }
  );

  return response.n >= 1 && response.nModified >= 1 && response.ok === 1
    ? res.send("Successfully Added.")
    : res.status(INTERNAL_SERVER_ERROR).send("Could not add the Items");
});

router.put("/:id/item/:itemId", validateId, async (req, res) => {
  const shoppingListId = req.params.id;
  const shoppingListItemId = req.params.itemId;

  if (!(await ShoppingListModel.exists({ _id: shoppingListId })))
    return res.status(NOT_FOUND).send("Shopping List not found");

  const isShoppingListItemExist = await ShoppingListModel.exists({
    "items._id": { $eq: shoppingListItemId },
  });

  if (!isShoppingListItemExist)
    return res.status(NOT_FOUND).send("Item not found in the Shopping List");

  const itemNewValues = req.query;

  const { error } = validateShoppingListItemNewValues(itemNewValues);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const updatedShoppingList = await ShoppingListModel.findOneAndUpdate(
    { _id: shoppingListId, owner: req.body.owner },
    {
      $set: {
        "items.$[item].price": parseFloat(itemNewValues.price),
        "items.$[item].bought": itemNewValues.bought === "true" ? true : false,
        "items.$[item].quantity": parseInt(itemNewValues.quantity),
      },
    },
    {
      arrayFilters: [{ "item.id": { $eq: shoppingListItemId } }],
      new: true,
      useFindAndModify: false,
    }
  );

  res.send(updatedShoppingList);
});

router.delete("/delete/many", async (req, res) => {
  const body = req.body;
  const listIds = body.listIds;

  const response = await ShoppingListModel.deleteMany({ owner: body.owner }).in(
    "_id",
    listIds
  );

  const deletedCount = response.deletedCount;

  const deletedPlural = deletedCount > 1 ? "s" : "";
  const noDeletedPlural = listIds.length > 1 ? "s" : "";

  response.ok === 1 && response.n > 0 && deletedCount > 0
    ? res.send(`Shopping List${deletedPlural} deleted.`)
    : res.status(BAD_REQUEST).send(`List${noDeletedPlural} not deleted.`);
});

router.delete("/:id", validateId, async (req, res) => {
  const deletedShoppingList = await ShoppingListModel.findByIdAndDelete(
    req.params.id
  );

  !deletedShoppingList
    ? res.status(NOT_FOUND).send("Shopping List not found")
    : res.send(deletedShoppingList);
});

router.delete("/:id/item/:itemId", validateId, async (req, res) => {
  const shoppingListId = req.params.id;
  const shoppingListItemId = req.params.itemId;

  const isShoppingListIdExist = await ShoppingListModel.exists({
    _id: shoppingListId,
  });

  if (!isShoppingListIdExist)
    return res.status(NOT_FOUND).send("Shopping List not found");

  const isShoppingListItemExist = await ShoppingListModel.findOne({
    "items._id": { $eq: shoppingListItemId },
    _id: { $eq: shoppingListId },
  });

  if (!isShoppingListItemExist)
    return res.status(NOT_FOUND).send("Item not found in the Shopping List");

  const updatedShoppingList = await ShoppingListModel.findOneAndUpdate(
    { _id: shoppingListId },
    { $pull: { items: { _id: shoppingListItemId } } },
    { new: true, useFindAndModify: false }
  );

  res.send(updatedShoppingList);
});

module.exports = router;
