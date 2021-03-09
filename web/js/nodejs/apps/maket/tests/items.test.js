const {
  ITEM_ENDPOINT,
  ITEM_MIN_LENGTH,
  ITEM_MAX_LENGTH,
  ITEM_CATEGORY_MIN_LENGTH,
  ITEM_CATEGORY_MAX_LENGTH,
} = require("../utils/constants/items");
const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
} = require("../utils/constants/httpResponseCodes");
const debug = require("debug")("maket:item_test");
const ItemModel = require("../models/items");
const ShoppingListModel = require("../models/shoppingList");
const buildEndpoint = require("../utils/endpoint/buildEndpoint");
const mongoose = require("mongoose");
const request = require("supertest");

describe(ITEM_ENDPOINT, () => {
  let server;
  let itemId;
  let itemValues;

  beforeEach(() => {
    server = require("../index");
    itemValues = { name: "Oranges", category: "Fruits" };
    itemId = mongoose.Types.ObjectId();
    queryString = {};
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

  const getItemById = (id) => {
    return ItemModel.findOne({ _id: id });
  };

  const createShoppingList = (itemId) => {
    const shoppingList = new ShoppingListModel({
      name: "Test",
      items: [{ _id: itemId, price: 12.99, bought: true }],
      description: "Test transaction on delete Item",
    });

    return shoppingList.save();
  };

  const clearShoppingListsDB = () => {
    return ShoppingListModel.deleteMany({});
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

    it("should return 400 if item's name is less than ITEM_MIN_LENGTH characters", async () => {
      itemValues.name = generateString(ITEM_MIN_LENGTH - 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name is more than ITEM_MAX_LENGTH characters", async () => {
      itemValues.name = generateString(ITEM_MAX_LENGTH + 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category is less than ITEM_CATEGORY_MIN_LENGTH characters", async () => {
      itemValues.category = generateString(ITEM_CATEGORY_MIN_LENGTH - 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category is more than ITEM_CATEGORY_MAX_LENGTH characters", async () => {
      itemValues.category = generateString(ITEM_CATEGORY_MAX_LENGTH + 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should save item if valid values provided", async () => {
      await exec();
      const itemInDb = await ItemModel.findOne({ name: itemValues.name });
      expect(itemInDb).not.toBeNull();
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

    it("should return 400 if item's name less than ITEM_MIN_LENGTH characters", async () => {
      newItemValues.name = generateString(ITEM_MIN_LENGTH - 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's name more than ITEM_MAX_LENGTH characters", async () => {
      newItemValues.name = generateString(ITEM_MAX_LENGTH + 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category less than ITEM_CATEGORY_MIN_LENGTH characters", async () => {
      newItemValues.category = generateString(ITEM_CATEGORY_MIN_LENGTH - 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if item's category more than ITEM_CATEGORY_MAX_LENGTH characters", async () => {
      newItemValues.category = generateString(ITEM_CATEGORY_MAX_LENGTH + 1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
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
      return request(server).delete(
        buildEndpoint(ITEM_ENDPOINT, [itemId], queryString)
      );
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

    it("should return 500 if the delete transaction failed", async () => {
      const item = await createItem();

      itemId = item._id;

      await createShoppingList(itemId);

      queryString.throw = true;

      const res = await exec();

      const itemInDb = await getItemById(itemId);

      await clearShoppingListsDB();

      expect(res.status).toBe(INTERNAL_SERVER_ERROR);
      expect(itemInDb).toBeTruthy();
    });

    it("should return 200 if item was deleted", async () => {
      const item = await createItem();

      itemId = item._id;

      await createShoppingList(itemId);

      const res = await exec();

      const itemInDb = await getItemById(itemId);

      await clearShoppingListsDB();

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("name", item.name);
      expect(res.body).toHaveProperty("category", item.category);
      expect(itemInDb).toBeFalsy();
    });
  });
});
