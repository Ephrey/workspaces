const auth = require("../middlewares/auth");
const bcrypt = require("bcrypt");
const _ = require("lodash");
const UserModel = require("../models/users");
const validateUser = require("../validators/users");
const express = require("express");
const router = express.Router();

router.get("/", async (req, res) => {
  res.send(await UserModel.find({}).sort({ name: 1 }));
});

router.get("/me", auth, async (req, res) => {
  const userId = req.user._id;

  const user = await UserModel.findById(userId).select("-password");
  res.send(user);
});

router.post("/", async (req, res) => {
  let user = req.body;

  const { error } = validateUser(user);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  try {
    const userExist = await UserModel.exists({ email: user.email });
    if (userExist) {
      return res.status(400).send("User already registered");
    }

    user = new UserModel(_.pick(user, ["name", "email", "password"]));
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);
    await user.save();

    const token = user.generateAuthToken();

    res
      .header("x-auth-token", token)
      .send(_.pick(user, ["id", "name", "email"]));
  } catch (err) {
    res.send(err.message);
  }
});

module.exports = router;
