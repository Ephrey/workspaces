const logger = require("../utils/logger");

module.exports = function (err, req, res, next) {
  logger.error(err.message, { metadata: { name: err.name, stack: err.stack } });
  // error
  // warn
  // info
  // verbose
  // debug
  // silly
  res.status(500).send("Something failed");
};
