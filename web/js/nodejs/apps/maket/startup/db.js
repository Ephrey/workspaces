const debug = require("debug")("maket:db");
const config = require("config");
const mongoose = require("mongoose");

module.exports = function () {
  const uri = config.get("db");
  return mongoose
    .connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useCreateIndex: true,
    })
    .then(() => debug(`Connected to ${uri} ...`))
    .catch((ex) => debug(ex.message));
};
