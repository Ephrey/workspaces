const items = require("../routes/items");
const itemConst = require("../utils/constants/items");
const express = require("express");

module.exports = function (app) {
  app.use(express.json());
  app.use(itemConst.ENDPOINT, items);
};
