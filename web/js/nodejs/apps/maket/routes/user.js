const { BAD_REQUEST } = require("../utils/constants/httpResponseCodes");
const {
  userRegisterValidate,
  userLoginValidate,
} = require("../validators/user");
const {
  USER_REGISTER_ENDPOINT,
  USER_LOGIN_ENDPOINT,
} = require("../utils/constants/user");
const { PASSWORD_HASH_SALT_ROUNDS } = require("../utils/constants/common");
const _ = require("lodash");
const bcrypt = require("bcrypt");
const debug = require("debug")("maket:userRoute");
const UserModel = require("../models/user");
const express = require("express");
const router = express.Router();

router.post(USER_REGISTER_ENDPOINT, async (req, res) => {
  const userDetails = req.body;

  const { error } = userRegisterValidate(userDetails);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const exist = await UserModel.exists({ email: userDetails.email });
  if (exist) return res.status(BAD_REQUEST).send("User already registered.");

  const hashedPassword = await bcrypt.hash(
    userDetails.password,
    PASSWORD_HASH_SALT_ROUNDS
  );

  const user = new UserModel(_.pick(userDetails, ["name", "email"]));
  user.password = hashedPassword;
  await user.save();

  res.set({ "x-token": user.generateToken() }).send();
});

router.post(USER_LOGIN_ENDPOINT, async (req, res) => {
  const userDetails = req.body;

  const { error } = userLoginValidate(userDetails);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  const user = await UserModel.findOne({ email: userDetails.email });
  if (!user) return res.status(BAD_REQUEST).send("Invalid Email or Password");

  const isValidPassword = await bcrypt.compare(
    userDetails.password,
    user.password
  );
  if (!isValidPassword)
    return res.status(BAD_REQUEST).send("Invalid Email or Password");

  res.set({ "x-token": user.generateToken() }).send();
});

module.exports = router;
