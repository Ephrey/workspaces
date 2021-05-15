const {
  SUCCESS,
  BAD_REQUEST,
} = require("../utils/constants/httpResponseCodes");
const debug = require("debug")("maket:userRoute");
const UserModel = require("../models/user");
const validateUser = require("../validators/user");
const express = require("express");
const router = express.Router();

router.post("/", async (req, res) => {
  const userDetails = req.body;

  // validate the value sent from client `
  const { error } = validateUser(userDetails);
  if (error) return res.status(BAD_REQUEST).send(error.details[0].message);

  // check if the user is already subscribed `
  const exist = await UserModel.exists({ email: userDetails.email });
  debug(exist);
  if (exist) return res.status(BAD_REQUEST).send("User already registered.");

  // hash password

  // build a new user
  const user = new UserModel(userDetails);

  // save the user
  // await user.save();

  // generate a token
  const token = user.generateToken();

  // set the token in response header
  const header = { "x-token": token };

  // send the response
  res.set(header).send();
});

module.exports = router;
