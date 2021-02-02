const mongoose = require("mongoose");
const logger = require("../utils/logger");

module.exports = function () {
  mongoose
    .connect("mongodb://localhost/vidly", {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
    })
    .then(() => logger.info("Connected to Server ..."));
};
