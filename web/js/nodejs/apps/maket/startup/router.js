const items = require("../routes/items");
const { ITEM_ENDPOINT } = require("../utils/constants/items");
const express = require("express");

module.exports = function (app) {
  app.use(express.json());
  app.use(ITEM_ENDPOINT, items);
};
