const { JSONWEBTOKEN_CONFIG_KEY } = require("../utils/constants/common");
const config = require("config");
const jwt = require("jsonwebtoken");

class JsonWebToke {
  static verify(token) {
    return jwt.verify(token, config.get(JSONWEBTOKEN_CONFIG_KEY));
  }
}

module.exports = JsonWebToke;
