const { JSONWEBTOKEN_CONFIG_KEY } = require("../utils/constants/common");
const {
  UNAUTHORIZED,
  BAD_REQUEST,
} = require("../utils/constants/httpResponseCodes");
const config = require("config");
const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.get("x-token");
  if (!token)
    return res
      .status(UNAUTHORIZED)
      .send("Unauthorized access. No token provided.");

  try {
    const decoded = jwt.verify(token, config.get(JSONWEBTOKEN_CONFIG_KEY));
    req.body.owner = decoded._id;

    next();
  } catch (e) {
    res.status(BAD_REQUEST).send("Invalid Token");
  }
};
