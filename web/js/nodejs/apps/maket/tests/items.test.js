const debug = require("debug")("maket");
const ItemModel = require("../models/items");
const { ITEM_ENDPOINT } = require("../utils/constants/items");
const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/response_codes");
const mongoose = require("mongoose");
const request = require("supertest");

let server;
let itemId;
let itemValues;

describe(ITEM_ENDPOINT, () => {
  beforeEach(() => {
    server = require("../index");
    itemValues = { name: "Oranges", category: "Fruits" };
    itemId = mongoose.Types.ObjectId();
  });

  afterEach(async () => {
    await server.close();
    await ItemModel.deleteMany({});
  });

  const exec = () => {
    return request(server).get(ITEM_ENDPOINT + itemId);
  };

  const createItem = () => {
    const item = new ItemModel(itemValues);
    return item.save();
  };

  const generateString = (length = 51) => {
    return new Array(length + 1).join("x");
  };

  describe("GET /", () => {
    it("should return all the items", async () => {
      await ItemModel.insertMany([
        { name: "Oranges", category: "Fruits" },
        { name: "Milk", category: "Other" },
        { name: "Cereal", category: "Nutrition" },
      ]);

      itemId = "";
      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body.length).toBe(3);
      expect(res.body.some((item) => item.name === "Oranges")).toBeTruthy();
      expect(res.body.some((item) => item.category === "Other")).toBeTruthy();
    });
  });

  describe("GET /id", () => {
    it("should return 400 if invalid item ID", async () => {
      itemId = "1";
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return an Item if valid ID", async () => {
      const item = await createItem();

      itemId = item._id;
      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body.name).toMatch(item.name);
    });

    it("should return 404 if no item with the given id exist", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });
  });

  describe("POST /", () => {
    const exec = () => {
      return request(server).post(ITEM_ENDPOINT).send(itemValues);
    };

    it("should return 400 if invalid item's values provided", async () => {
      itemValues = {};
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name is less than 2 characters", async () => {
      itemValues.name = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name is more than 50 characters", async () => {
      itemValues.name = generateString();
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category is less than 2 characters", async () => {
      itemValues.category = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category is more than 50 characters", async () => {
      itemValues.category = generateString();
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should save item if valid values provided", async () => {
      await exec();
      const itemInDb = await ItemModel.findOne({ name: itemValues.name });
      expect(itemInDb).toHaveProperty("name", itemValues.name);
    });

    it("should return the created item", async () => {
      const res = await exec();
      expect(res.body).toHaveProperty("name", itemValues.name);
    });
  });

  describe("PUT /", () => {
    let newItemValues;

    beforeEach(() => {
      newItemValues = { name: "Orange", category: "Fruits" };
    });

    const exec = () => {
      return request(server)
        .put(ITEM_ENDPOINT + itemId)
        .send(newItemValues);
    };

    it("should return 400 if invalid item's ID provided", async () => {
      itemId = "1";
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if new item's values not provided", async () => {
      newItemValues = {};
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name less than 2 characters", async () => {
      newItemValues.name = generateString(1);
      const rest = await exec();
      expect(rest.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name more 50 characters", async () => {
      newItemValues.name = generateString();
      debug(newItemValues);
      const rest = await exec();
      expect(rest.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's description less than 2 characters", async () => {
      newItemValues.description = generateString(1);
      const rest = await exec();
      expect(rest.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's description more 50 characters", async () => {
      newItemValues.description = generateString();
      const rest = await exec();
      expect(rest.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if item not found", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should update item if valid item's ID and new values passed", async () => {
      const item = await createItem();

      itemId = item._id;
      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("name", newItemValues.name);
    });
  });

  describe("DELETE /", () => {
    const exec = () => {
      return request(server).delete(ITEM_ENDPOINT + itemId);
    };

    it("should return 400 if invalid item ID passed", async () => {
      itemId = "1";
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if item not found for the given ID", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 200 if item was deleted", async () => {
      const item = await createItem();

      itemId = item._id;
      const res = await exec();

      const itemInDb = await ItemModel.findOne({ _id: itemId });

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("name", item.name);
      expect(res.body).toHaveProperty("category", item.category);
      expect(itemInDb).toBeFalsy();
    });
  });
});
