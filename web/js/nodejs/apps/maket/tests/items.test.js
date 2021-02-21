const ItemModel = require("../models/items");
const itemConst = require("../utils/constants/items");
const mongoose = require("mongoose");
const request = require("supertest");

let server;
let itemId;

describe(itemConst.ENDPOINT, () => {
  beforeEach(() => (server = require("../index")));
  afterEach(async () => {
    await server.close();
    await ItemModel.deleteMany({});
  });

  const exec = function () {
    return request(server).get(itemConst.ENDPOINT + itemId);
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

      expect(res.status).toBe(200);
      expect(res.body.length).toBe(3);
      expect(res.body.some((item) => item.name === "Oranges")).toBeTruthy();
      expect(res.body.some((item) => item.category === "Other")).toBeTruthy();
    });
  });

  describe("GET /id", () => {
    it("should return 400 if invalid item ID", async () => {
      itemId = "1";
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should return an Item if valid ID", async () => {
      const item = new ItemModel({ name: "Oranges", category: "Fruits" });
      await item.save();

      itemId = item._id;
      const res = await exec();

      expect(res.status).toBe(200);
      expect(res.body.name).toMatch(item.name);
    });

    it("should return 404 if no item with the given id exist", async () => {
      itemId = mongoose.Types.ObjectId();
      const res = await exec();
      expect(res.status).toBe(404);
    });
  });

  describe("POST /", () => {
    let item;

    beforeEach(() => {
      item = { name: "Oranges", category: "Fruits" };
    });

    const exec = function () {
      return request(server).post(itemConst.ENDPOINT).send(item);
    };

    it("should return 400 if invalid item's values provided", async () => {
      item = {};
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should return 400 if item's name is less than 2 characters", async () => {
      item.name = "1";
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should return 400 if item's category is less than 2 characters", async () => {
      item.category = "1";
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should save item if valid values provided", async () => {
      await exec();
      const itemInDb = await ItemModel.findOne({ name: item.name });
      expect(itemInDb).toHaveProperty("name", item.name);
    });

    it("should return the item", async () => {
      const res = await exec();
      expect(res.body).toHaveProperty("name", item.name);
    });
  });
});
