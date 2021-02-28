const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/httpResponseCodes");
const { SHOPPING_LIST_ENDPOINT } = require("../utils/constants/shoppingList");
const ShoppingListModel = require("../models/shoppingList");
const debug = require("debug")("maket:shop_list_test");
const _ = require("lodash");
const mongoose = require("mongoose");
const request = require("supertest");

describe(SHOPPING_LIST_ENDPOINT, () => {
  beforeEach(() => {
    server = require("../index");
    shoppingListId = mongoose.Types.ObjectId();
    shoppingList = createShoppingList();
    shoppingListValues = getShoppingListValues();
    newShoppingListValues = getNewShoppingListValues();
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

  const getShoppingListValues = () => {
    const { name, items, description } = shoppingList;
    return { name, items, description };
  };

  const getNewShoppingListValues = () => {
    return {
      name: "New Shopping List Name",
      items: [
        { _id: mongoose.Types.ObjectId(), price: 0.0, bought: false },
        { _id: mongoose.Types.ObjectId(), price: 2.99, bought: true },
      ],
      description: "New description",
    };
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
      shoppingListId = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List for the given ID does not exist", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 200 if valid Shopping List ID is valid", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      const res = await exec();
      expect(res.status).toBe(SUCCESS);
    });

    it("should return the Shopping List for the given ID", async () => {
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
    const exec = function () {
      return request(server)
        .post(SHOPPING_LIST_ENDPOINT)
        .send(shoppingListValues);
    };

    it("should return 400 if empty Shopping List provided", async () => {
      shoppingListValues = {};
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is empty", async () => {
      _.set(shoppingListValues, "name", "");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is less than 2 characters", async () => {
      _.set(shoppingListValues, "name", generateString(1));

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is greater than 50 characters", async () => {
      _.set(shoppingListValues, "name", generateString());

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items is empty", async () => {
      _.set(shoppingListValues, "items", []);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0]._id is not set", async () => {
      shoppingListValues.items[0] = { bought: true, price: 22.99 };

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0]._id is empty", async () => {
      shoppingListValues.items[0] = { _id: "" };

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0]._id is not valid ObjectId", async () => {
      shoppingListValues.items[0] = { _id: "1" };

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is not set", async () => {
      shoppingListValues.items[0] = { _id: shoppingListId, bought: true };

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is not a number", async () => {
      shoppingListValues.items[0].price = "";

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is less than 0", async () => {
      shoppingListValues.items[0].price = -1.0;

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is greater than 50000", async () => {
      shoppingListValues.items[0].price = 50100.0;

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].bought is not set", async () => {
      shoppingListValues.items[0] = { _id: shoppingListId, price: 18.99 };

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].bought is not boolean", async () => {
      shoppingListValues.items[0] = {
        _id: shoppingListId,
        price: 20.0,
        bought: generateString(1),
      };
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List Description is not set", async () => {
      _.unset(shoppingListValues, "description");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List Description is not a string", async () => {
      _.set(shoppingListValues, "description", 0);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List Description is greater than 50 characters", async () => {
      _.set(shoppingListValues, "description", generateString());

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 200 if valid Shopping List's values provided", async () => {
      const res = await exec();
      expect(res.status).toBe(SUCCESS);
    });

    it("should save the Shopping List if valid values provided", async () => {
      const res = await exec();
      expect(res.body).toHaveProperty("name", shoppingListValues.name);
      expect(res.body).toHaveProperty("_id");
    });
  });

  describe("PUT /id", () => {
    const exec = () => {
      return request(server)
        .put(SHOPPING_LIST_ENDPOINT + shoppingListId)
        .send(newShoppingListValues);
    };

    it("should return 400 if Shopping List ID is invalid", async () => {
      shoppingListId = generateString(1);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if empty Shopping List values provided", async () => {
      newShoppingListValues = {};

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is not set", async () => {
      _.unset(newShoppingListValues, "name");
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is empty", async () => {
      _.set(newShoppingListValues, "name", "");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is less than 2 characters", async () => {
      _.set(newShoppingListValues, "name", generateString(1));

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is greater than 50 characters", async () => {
      _.set(newShoppingListValues, "name", generateString());

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items is empty", async () => {
      _.set(newShoppingListValues, "items", []);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0]._id is not set", async () => {
      _.unset(newShoppingListValues, "items[0]._id");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0]._id is not a valid object ID", async () => {
      _.set(newShoppingListValues, "items[0]._id", generateString(1));

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List  items[0].price is not set", async () => {
      _.unset(newShoppingListValues, "items[0].price");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is not a number", async () => {
      _.set(newShoppingListValues, "items[0].price", generateString(1));

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is less than 0", async () => {
      _.set(newShoppingListValues, "items[0].price", -1);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is greater than 50000", async () => {
      _.set(newShoppingListValues, "items[0].price", 50001);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List description is not set", async () => {
      _.unset(newShoppingListValues, "description");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List description is greater than 50 characters", async () => {
      _.set(newShoppingListValues, "description", generateString());

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List not found for the given ID", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should save the new Shopping List if valid values provided", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;

      const res = await exec();

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("name", newShoppingListValues.name);
    });
  });

  describe("DELETE /id", () => {
    const exec = () => {
      return request(server).delete(SHOPPING_LIST_ENDPOINT + shoppingListId);
    };

    it("should return 400 if Shopping List ID is not valid", async () => {
      shoppingListId = generateString(1);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List not found for the given ID", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should delete the Shopping List for the given ID", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;

      const res = await exec();

      const result = await ShoppingListModel.findById(shoppingListId);

      expect(res.status).toBe(SUCCESS);
      expect(res.body).toHaveProperty("_id", shoppingListId.toString());
      expect(result).toBeNull();
    });
  });
});
