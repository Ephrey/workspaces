const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/httpResponseCodes");
const { SHOPPING_LIST_ENDPOINT } = require("../utils/constants/shoppingList");
const ShoppingListModel = require("../models/shoppingList");
const debug = require("debug")("maket");
const mongoose = require("mongoose");
const request = require("supertest");

describe(SHOPPING_LIST_ENDPOINT, () => {
  let server;
  let shoppingListId;
  let shoppingList;

  beforeEach(() => {
    server = require("../index");
    shoppingList = {};
  });
  afterEach(async () => {
    await server.close();
    await ShoppingListModel.deleteMany({});
  });

  const createShoppingList = () => {
    return new ShoppingListModel({
      name: "January Grocery",
      items: [
        { _id: mongoose.Types.ObjectId(), price: 93.39, bought: true },
        { _id: mongoose.Types.ObjectId(), price: 23.99, bought: true },
        { _id: mongoose.Types.ObjectId(), price: 49.99, bought: false },
      ],
      description: "For my birthday party :)",
    });
  };

  const generateString = (length = 51) => {
    return new Array(length + 1).join("x");
  };

  const exec = () => {
    return request(server).get(SHOPPING_LIST_ENDPOINT + shoppingListId);
  };

  describe("GET /", () => {
    it("should return all Shopping List", async () => {
      shoppingListId = "";
      const shoppingList = createShoppingList();
      await shoppingList.save();

      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body.length).toBe(1);
      expect(
        res.body.some((shoppingList) => shoppingList.name === shoppingList.name)
      ).toBeTruthy();
      expect(
        res.body.some(
          (shoppingList) =>
            shoppingList.items[0].price === shoppingList.items[0].price
        )
      ).toBeTruthy();
    });
  });

  describe("GET /id", () => {
    it("should return 400 if invalid Shopping List ID provided", async () => {
      shoppingListId = "1";
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List for the given ID does not exist", async () => {
      shoppingListId = mongoose.Types.ObjectId();
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 200 if valid Shopping List ID is valid", async () => {
      const shoppingList = createShoppingList();
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      const res = await exec();
      expect(res.status).toBe(SUCCESS);
    });

    it("should return the Shopping List if valid ID", async () => {
      const shoppingList = createShoppingList();
      shoppingList.save();

      shoppingListId = shoppingList._id;

      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("name", shoppingList.name);
      expect(res.body.items.length).toBe(shoppingList.items.length);
      expect(
        res.body.items.some(
          (item) => item.price === shoppingList.items[2].price
        )
      ).toBeTruthy();
    });
  });

  describe("POST /", () => {
    const exec = () => {
      return request(server).post(SHOPPING_LIST_ENDPOINT).send(shoppingList);
    };

    it("should return 400 if empty Shopping List provided", async () => {
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is not provided", async () => {
      shoppingList = createShoppingList();
      shoppingList.name = "";

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is less than 2 characters", async () => {
      shoppingList = createShoppingList();
      shoppingList.name = generateString(1);

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });
  });
});
