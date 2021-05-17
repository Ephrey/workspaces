const items = require("../routes/items");
const shoppingList = require("../routes/shoppingList");
const user = require("../routes/user");
const { ITEM_ENDPOINT } = require("../utils/constants/items");
const { SHOPPING_LIST_ENDPOINT } = require("../utils/constants/shoppingList");
const { USER_ENDPOINT } = require("../utils/constants/user");
const express = require("express");
const helmet = require("helmet");

module.exports = function (app) {
  app.use(helmet());
  app.use(express.json());
  app.use(ITEM_ENDPOINT, items);
  app.use(SHOPPING_LIST_ENDPOINT, shoppingList);
  app.use(USER_ENDPOINT, user);
};
