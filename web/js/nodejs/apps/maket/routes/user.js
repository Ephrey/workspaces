const {
  BAD_REQUEST,
  SUCCESS,
} = require("../utils/constants/httpResponseCodes");
const {
  userRegisterValidate,
  userLoginValidate,
} = require("../validators/user");
const {
  USER_REGISTER_ENDPOINT,
  USER_LOGIN_ENDPOINT,
} = require("../utils/constants/user");
const { PASSWORD_HASH_SALT_ROUNDS } = require("../utils/constants/common");
const { X_TOKEN } = require("../utils/constants/headersKeys");
const JsonWebToke = require("../validators/jsonWebToken");
const _ = require("lodash");
const bcrypt = require("bcrypt");
const debug = require("debug")("maket:userRoute");
const UserModel = require("../models/user");
const RestorePasswordCodeModel = require("../models/restorePasswordCode");
const express = require("express");
const router = express.Router();

router.post(USER_REGISTER_ENDPOINT, async (req, res) => {
  const userDetails = req.body;

  debug(userDetails);

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

  let token = req.get(X_TOKEN);

  if (token) {
    try {
      if (JsonWebToke.verify(token)._id != user._id) {
        token = user.generateToken();
      }
    } catch (e) {
      return res.status(BAD_REQUEST).send("Cannot verify your details");
    }
  } else {
    token = user.generateToken();
  }

  res.set({ "x-token": token }).send();
});

router.post("/verify_email", async (req, res) => {
  const email = req.body.email;

  debug(req.body.email);

  const emailExist = await UserModel.exists({ email: email });

  const responseCode = emailExist ? SUCCESS : BAD_REQUEST;
  const responseMessage = emailExist ? "Email Found" : "Email not Found";

  if (emailExist) {
    const code = RestorePasswordCodeModel.generateCode();
    const restoreDetails = new RestorePasswordCodeModel({
      email: email,
      code: code,
    });

    restoreDetails.save();
  }

  res.status(responseCode).send(responseMessage);
});

module.exports = router;
