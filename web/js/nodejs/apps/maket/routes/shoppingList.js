const {
  BAD_REQUEST,
  NOT_FOUND,
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
const router = express.Router();

router.use(authorization);

router.get("/", async (req, res) => {
  res.send(
    await ShoppingListModel.find({ owner: req.body.owner }).sort("-createdDate")
  );
});

router.get("/body", async (req, res) => {
  res.send(
    await ShoppingListModel.find({ owner: req.body.owner })
      .sort("-_id")
      .select("-items -owner -__v")
  );
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
    { _id: shoppingListId },
    {
      $set: {
        "items.$[item].price": itemNewValues.price,
        "items.$[item].bought": itemNewValues.bought,
        "items.$[item].quantity": itemNewValues.quantity,
      },
    },
    {
      arrayFilters: [{ "item._id": { $eq: shoppingListItemId } }],
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

  debug(response.n);
  debug(response.ok);
  debug(response.deletedCount);
  debug(body.owner);
  debug(listIds);

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
