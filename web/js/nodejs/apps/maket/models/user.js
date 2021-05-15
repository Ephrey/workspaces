const {
  USER_NAME_MIN_LENGTH,
  USER_NAME_MAX_LENGTH,
  PASSWORD_MIN_LENGTH,
} = required("../utils/constants/user");
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

const UserModel = mongoose.model("Users", userSchema);

module.exports = UserModel;
