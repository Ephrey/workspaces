const logger = require("./utils/logger");
const express = require("express");
const app = express();

require("./startup/config")();
require("./startup/logging")();
require("./startup/routes")(app);
require("./startup/db")();
require("./startup/validation")();

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => logger.info("Listening on port " + PORT));
