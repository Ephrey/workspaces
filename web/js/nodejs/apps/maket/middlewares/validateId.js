const { BAD_REQUEST } = require("../utils/constants/httpResponseCodes");
const mongoose = require("mongoose");

module.exports = (req, res, next) => {
  if (!isValidObjectId(req.params.id)) {
    return res.status(BAD_REQUEST).send("Invalid ID");
  }

  if (req.params.itemId) {
    if (!isValidObjectId(req.params.itemId))
      return res.status(BAD_REQUEST).send("Invalid Item ID");
  }

  next();
};

const isValidObjectId = (id) => {
  return mongoose.Types.ObjectId.isValid(id);
};
