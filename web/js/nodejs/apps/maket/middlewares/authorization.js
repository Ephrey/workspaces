const { X_TOKEN } = require("../utils/constants/headersKeys");
const {
  UNAUTHORIZED,
  BAD_REQUEST,
} = require("../utils/constants/httpResponseCodes");
const JsonWebToke = require("../validators/jsonWebToken");
const debug = require("debug")("maket:auth_middleware");

module.exports = (req, res, next) => {
  const token = req.get(X_TOKEN);
  if (!token)
    return res
      .status(UNAUTHORIZED)
      .send("Unauthorized access. No token provided.");

  try {
    const decodedJwtToken = JsonWebToke.verify(token);
    req.body.owner = decodedJwtToken._id;

    next();
  } catch (e) {
    res.status(BAD_REQUEST).send("Invalid Token");
  }
};
