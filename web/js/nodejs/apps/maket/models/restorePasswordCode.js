const mongoose = require("mongoose");
const {
  CODE_MIN_LENGTH,
  CODE_MAX_LENGTH,
} = require("../utils/constants/restorePasswordCode");
const {
  USER_EMAIL_MAX_LENGTH,
  USER_EMAIL_MIN_LENGTH,
} = require("../utils/constants/user");

const restorePasswordCodeSchema = new mongoose.Schema({
  email: {
    type: String,
    minLength: USER_EMAIL_MIN_LENGTH,
    maxLength: USER_EMAIL_MAX_LENGTH,
    unique: true,
    required: true,
    trim: true,
  },
  code: {
    type: String,
    min: CODE_MIN_LENGTH,
    max: CODE_MAX_LENGTH,
    default: generateCode(),
  },
});

const RestorePasswordCodeModel = mongoose.model(
  "Otps",
  restorePasswordCodeSchema
);

function generateCode() {
  return Math.floor(1000 + Math.random() * 9000) + "";
}

module.exports = RestorePasswordCodeModel;
