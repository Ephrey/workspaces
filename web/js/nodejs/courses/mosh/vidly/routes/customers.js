const auth = require("../middlewares/auth");
const CustomerModel = require("../models/customers");
const validateCustomer = require("../validators/customers");
const express = require("express");
const router = express.Router();

/**
 * POST : Create a Customer
 */
router.post("/", auth, async (req, res) => {
  let customer = req.body;

  const { error } = validateCustomer(customer);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  customer = new CustomerModel(customer);

  try {
    res.send(await customer.save());
  } catch (err) {
    res.send(err.message);
  }
});

/**
 * GET : Read All Customer
 */
router.get("/", async (req, res) => {
  try {
    const customers = await CustomerModel.find({}).sort({ name: 1 });
    res.send(customers);
  } catch (err) {
    res.send(err.message);
  }
});

/**
 * GET: Read a Single Customer
 */
router.get("/:id", async (req, res) => {
  const customerId = req.params.id;

  if (customerId.length !== 24) {
    return res.status(400).send("Invalid ID");
  }

  try {
    const customer = await CustomerModel.findById(customerId);

    if (!customer) {
      return res.status(404).send("Customer not found");
    }

    res.send(customer);
  } catch (err) {
    res.send(err.message);
  }
});

/**
 * PUT : Update a Single Customer
 */
router.put("/:id", auth, async (req, res) => {
  const customerId = req.params.id;

  if (customerId.length !== 24) {
    return res.status(400).send("Invalid ID");
  }

  let customer = req.body;

  const { error } = validateCustomer(customer);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  try {
    customer = await CustomerModel.findByIdAndUpdate(customerId, customer, {
      new: true,
    });

    if (!customer) {
      return res.status(404).send("Customer not found");
    }

    res.send(customer);
  } catch (err) {
    res.send(err.message);
  }
});

/**
 * DELETE : Delete a Single Customer
 */
router.delete("/:id", auth, async (req, res) => {
  const customerId = req.params.id;

  if (customerId.length !== 24) {
    return res.status(400).send("Invalid ID");
  }

  try {
    const customer = await CustomerModel.findByIdAndRemove(customerId);

    if (!customer) {
      return res.status(404).send("Customer not found");
    }

    res.send(customer);
  } catch (err) {
    res.send(err.message);
  }
});

module.exports = router;
