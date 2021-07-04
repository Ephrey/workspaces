const {
  BAD_REQUEST,
  SUCCESS,
  INTERNAL_SERVER_ERROR,
  FOUND,
} = require("../utils/constants/httpResponseCodes");
const {
  userRegisterValidate,
  userLoginValidate,
} = require("../validators/user");
const {
  USER_REGISTER_ENDPOINT,
  USER_LOGIN_ENDPOINT,
  USER_VERIFY_EMAIL_ENDPOINT,
  USER_VERIFY_OTP_CODE_ENDPOINT,
  USER_UPDATE_PASSWORD_ENDPOINT,
} = require("../utils/constants/user");
const { PASSWORD_HASH_SALT_ROUNDS } = require("../utils/constants/common");
const { X_TOKEN } = require("../utils/constants/headersKeys");
const Email = require("../utils/mail/email");
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

router.post(USER_VERIFY_EMAIL_ENDPOINT, async (req, res) => {
  try {
    const userEmail = req.body.email;

    const emailExist = await UserModel.exists({ email: userEmail });

    let codeSent = false;

    if (emailExist) {
      if (await RestorePasswordCodeModel.exists({ email: userEmail })) {
        return res
          .status(FOUND)
          .send("Verification code already sent. \n Check your Email");
      }

      const restoreDetails = new RestorePasswordCodeModel({ email: userEmail });

      const mail = new Email(
        '"Maket App" <help@maket.com>',
        restoreDetails.email,
        "Confirmation Code is #" + restoreDetails.code,
        "<h1>Hope to See you There ...</h1>"
      );

      mail.initTransport();
      const emailResponse = await mail.send();

      if (emailResponse.rejected.length === 0) {
        if (await restoreDetails.save()) {
          codeSent = true;
        }
      }
    }

    let responseCode = BAD_REQUEST;
    let responseMessage = "";

    if (emailExist && codeSent) {
      responseCode = SUCCESS;
      responseMessage = "Verification Code sent";
    } else if (emailExist && !codeSent) {
      responseMessage = "Verification Code not sent";
    } else {
      responseMessage = "Email not found";
    }

    return res.status(responseCode).send(responseMessage);
  } catch (ex) {
    debug(ex);
    return res.status(INTERNAL_SERVER_ERROR).send("Server Error. Try again.");
  }
});

router.post(USER_VERIFY_OTP_CODE_ENDPOINT, async (req, res) => {
  try {
    const email = req.body.email;
    const otp = req.body.otp;

    debug(otp);
    debug(email);

    const isValidCode = await RestorePasswordCodeModel.exists({
      code: otp,
      email: email,
    });

    let message = "Valid Code.";
    let responseCode = SUCCESS;

    if (!isValidCode) {
      message = "Invalid or Unknown Code.";
      responseCode = BAD_REQUEST;
    }

    return res.status(responseCode).send(message);
  } catch (ex) {
    const message = "Couldn't not verify your OTP Code.";
    return res.status(INTERNAL_SERVER_ERROR).send(message);
  }
});

router.put(USER_UPDATE_PASSWORD_ENDPOINT, async (req, res) => {
  try {
    const email = req.body.email;

    const hashedPassword = await bcrypt.hash(
      req.body.password,
      PASSWORD_HASH_SALT_ROUNDS
    );

    const updatedUser = await UserModel.findOneAndUpdate(
      { email: email },
      { password: hashedPassword },
      { new: true, useFindAndModify: false }
    );

    if (updatedUser) {
      await RestorePasswordCodeModel.deleteMany({ email: email });
    }

    const token = updatedUser.generateToken();
    const message = "Successfully updated.";
    res.set({ "x-token": token }).status(SUCCESS).send(message);
  } catch (ex) {
    debug(ex.message);
    return res.status(INTERNAL_SERVER_ERROR).send("Could not update password");
  }
});

module.exports = router;
