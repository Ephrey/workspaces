const logger = require("./utils/logger");
const express = require("express");
const app = express();

require("./startup/config")();
require("./startup/logging")();
require("./startup/routes")(app);
require("./startup/db")();
require("./startup/validation")();
require("./startup/prod")(app);

const PORT = process.env.PORT || 3000;
const server = app.listen(PORT, () => logger.info("Listening on port " + PORT));

module.exports = server;
