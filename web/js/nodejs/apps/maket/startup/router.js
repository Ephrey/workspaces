const items = require("../routes/items");
const shoppingList = require("../routes/shoppingList");
const { ITEM_ENDPOINT } = require("../utils/constants/items");
const { SHOPPING_LIST_ENDPOINT } = require("../utils/constants/shoppingList");
const express = require("express");

module.exports = function (app) {
  app.use(express.json());
  app.use(ITEM_ENDPOINT, items);
  app.use(SHOPPING_LIST_ENDPOINT, shoppingList);
};
