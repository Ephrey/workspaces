const {
  USER_NAME_MIN_LENGTH,
  USER_NAME_MAX_LENGTH,
  USER_PASSWORD_MIN_LENGTH,
  USER_HASHED_PASSWORD_MAX_LENGTH,
  USER_EMAIL_MIN_LENGTH,
  USER_EMAIL_MAX_LENGTH,
} = require("../utils/constants/user");
const { JSONWEBTOKEN_CONFIG_KEY } = require("../utils/constants/common");
const config = require("config");
const jwt = require("jsonwebtoken");
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    minLength: USER_NAME_MIN_LENGTH,
    maxLength: USER_NAME_MAX_LENGTH,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    minLength: USER_EMAIL_MIN_LENGTH,
    maxLength: USER_EMAIL_MAX_LENGTH,
    unique: true,
    required: true,
    trim: true,
  },
  password: {
    type: String,
    minLength: USER_PASSWORD_MIN_LENGTH,
    maxLength: USER_HASHED_PASSWORD_MAX_LENGTH,
    trim: true,
  },
  createDate: {
    type: Date,
    default: new Date(),
  },
});

userSchema.methods.generateToken = function () {
  return jwt.sign({ _id: this._id }, config.get(JSONWEBTOKEN_CONFIG_KEY));
};

const UserModel = mongoose.model("Users", userSchema);

module.exports = UserModel;
