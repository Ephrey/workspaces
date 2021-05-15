const {
  USER_NAME_MIN_LENGTH,
  USER_NAME_MAX_LENGTH,
  PASSWORD_MIN_LENGTH,
} = require("../utils/constants/user");
const config = require("config");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    min: USER_NAME_MIN_LENGTH,
    max: USER_NAME_MAX_LENGTH,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
  },
  password: {
    type: String,
    min: PASSWORD_MIN_LENGTH,
    trim: true,
  },
  createDate: {
    type: Date,
    default: new Date(),
  },
});

userSchema.methods.generateToken = function () {
  return jwt.sign({ _id: this._id }, config.get("jsonwebtoken"));
};

const UserModel = mongoose.model("Users", userSchema);

module.exports = UserModel;
