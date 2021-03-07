const {
  SUCCESS,
  BAD_REQUEST,
  NOT_FOUND,
} = require("../utils/constants/httpResponseCodes");
const {
  SHOPPING_LIST_ENDPOINT,
  SHOPPING_LIST_NAME_MIN_LENGTH,
  SHOPPING_LIST_NAME_MAX_LENGTH,
  SHOPPING_LIST_DESCRIPTION_MAX_LENGTH,
} = require("../utils/constants/shoppingList");
const { ITEM_PRICE_MIN, ITEM_PRICE_MAX } = require("../utils/constants/items");
const buildEndpoint = require("../utils/endpoint/buildEndpoint");
const ShoppingListModel = require("../models/shoppingList");
const debug = require("debug")("maket:shop_list_test");
const _ = require("lodash");
const mongoose = require("mongoose");
const request = require("supertest");

describe(SHOPPING_LIST_ENDPOINT, () => {
  beforeEach(() => {
    server = require("../index");
    shoppingListId = generateObjectId();
    shoppingList = createShoppingList();
    shoppingListValues = getShoppingListValues();
    newShoppingListValues = getNewShoppingListValues();
    shoppingListItemId = generateObjectId();
    queryString = getQueryStringItemValues();
  });

  afterEach(async () => {
    await server.close();
    await ShoppingListModel.deleteMany({});
  });

  const createShoppingList = () => {
    return new ShoppingListModel({
      name: "January Grocery",
      items: [
        { _id: generateObjectId(), price: 93.39, bought: false },
        { _id: generateObjectId(), price: 23.99, bought: false },
        { _id: generateObjectId(), price: 49.99, bought: false },
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
        { _id: generateObjectId(), price: 0.0, bought: false },
        { _id: generateObjectId(), price: 2.99, bought: true },
      ],
      description: "New description",
    };
  };

  const getQueryStringItemValues = () => {
    return { price: 20.99, bought: true };
  };

  const generateString = (length = 51) => {
    return new Array(length + 1).join("x");
  };

  const generateObjectId = () => {
    return mongoose.Types.ObjectId().toHexString();
  };

  const exec = () => {
    return request(server).get(
      buildEndpoint(SHOPPING_LIST_ENDPOINT, [shoppingListId])
    );
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
        .post(buildEndpoint(SHOPPING_LIST_ENDPOINT))
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

    it("should return 400 if Shopping List name is less than SHOPPING_LIST_NAME_MIN_LENGTH characters", async () => {
      _.set(
        shoppingListValues,
        "name",
        generateString(SHOPPING_LIST_NAME_MIN_LENGTH - 1)
      );

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is greater than SHOPPING_LIST_NAME_MAX_LENGTH characters", async () => {
      _.set(
        shoppingListValues,
        "name",
        generateString(SHOPPING_LIST_NAME_MAX_LENGTH + 1)
      );

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

    it("should return 400 if Shopping List items[0].price is less than ITEM_PRICE_MIN", async () => {
      shoppingListValues.items[0].price = ITEM_PRICE_MIN - 1;

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is greater than ITEM_PRICE_MAX", async () => {
      shoppingListValues.items[0].price = ITEM_PRICE_MAX + 1;

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

    it("should return 400 if Shopping List Description is greater than SHOPPING_LIST_DESCRIPTION_MAX_LENGTH characters", async () => {
      _.set(
        shoppingListValues,
        "description",
        generateString(SHOPPING_LIST_DESCRIPTION_MAX_LENGTH + 1)
      );

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
        .put(buildEndpoint(SHOPPING_LIST_ENDPOINT, [shoppingListId]))
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

    it("should return 400 if Shopping List name is less than SHOPPING_LIST_NAME_MIN_LENGTH characters", async () => {
      _.set(
        newShoppingListValues,
        "name",
        generateString(SHOPPING_LIST_NAME_MIN_LENGTH - 1)
      );

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List name is greater than SHOPPING_LIST_NAME_MAX_LENGTH characters", async () => {
      _.set(
        newShoppingListValues,
        "name",
        generateString(SHOPPING_LIST_NAME_MAX_LENGTH + 1)
      );

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

    it("should return 400 if Shopping List items[0].price is less than ITEM_PRICE_MIN", async () => {
      _.set(newShoppingListValues, "items[0].price", ITEM_PRICE_MIN - 1);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List items[0].price is greater than ITEM_PRICE_MAX", async () => {
      _.set(newShoppingListValues, "items[0].price", ITEM_PRICE_MAX + 1);

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List description is not set", async () => {
      _.unset(newShoppingListValues, "description");

      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List description is greater than SHOPPING_LIST_DESCRIPTION_MAX_LENGTH characters", async () => {
      _.set(
        newShoppingListValues,
        "description",
        generateString(SHOPPING_LIST_DESCRIPTION_MAX_LENGTH + 1)
      );

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

  describe("PUT /id/item/itemId?price=10.90&bought=true", () => {
    const exec = () => {
      return request(server).put(
        buildEndpoint(
          SHOPPING_LIST_ENDPOINT,
          [shoppingListId, "item", shoppingListItemId],
          queryString
        )
      );
    };

    it("should return 400 if Shopping List ID is invalid", async () => {
      shoppingListId = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if Shopping List's Item ID is invalid", async () => {
      shoppingListItemId = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List not found for the given Id", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 404 if Item is not found in Shopping List Items", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;

      const res = await exec();

      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 400 if the Item new values is not provided", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      queryString = {};

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if price is not set", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      _.unset(queryString, "price");

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if price is not a valid number", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      queryString.price = generateString(1);

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if price is less than ITEM_PRICE_MIN", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      queryString.price = ITEM_PRICE_MIN - 1;

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if price is greater than ITEM_PRICE_MAX", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      queryString.price = ITEM_PRICE_MAX + 1;

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if bought is not set", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      _.unset(queryString, "bought");

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if bought is not a valid boolean", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      queryString.bought = generateString(1);

      const res = await exec();

      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 200 if Shopping List and Item exist", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      const res = await exec();

      expect(res.status).toBe(SUCCESS);
    });

    it("should return the Shopping List with the updated Item", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      const res = await exec();

      expect(res.status).toBe(SUCCESS);

      expect(res.body.items[0]._id).toBe(shoppingListItemId.toString());
      expect(res.body.items[0].price).toBe(queryString.price);
      expect(res.body.items[0].bought).toBe(queryString.bought);
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

  describe("DELETE /id/item/itemId", () => {
    const exec = () => {
      return request(server).delete(
        buildEndpoint(SHOPPING_LIST_ENDPOINT, [
          shoppingListId,
          "item",
          shoppingListItemId,
        ])
      );
    };

    it("should return 400 if the Shopping List ID is not valid", async () => {
      shoppingListId = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 400 if the Shopping List's Item ID is invalid", async () => {
      shoppingListItemId = generateString(1);
      const res = await exec();
      expect(res.status).toBe(BAD_REQUEST);
    });

    it("should return 404 if Shopping List is not found for the given ID", async () => {
      const res = await exec();
      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 404 if Item for the given ID is not found in Shopping List Items", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;

      const res = await exec();

      expect(res.status).toBe(NOT_FOUND);
    });

    it("should return 200 if Shopping List for the given ID exist and contains the Item for the given Item ID", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      const res = await exec();

      expect(res.status).toBe(SUCCESS);
    });

    it("should delete the Item for the given Item ID from the Shopping List", async () => {
      await shoppingList.save();

      shoppingListId = shoppingList._id;
      shoppingListItemId = shoppingList.items[0]._id;

      const res = await exec();

      expect(res.body.items.length).toBe(shoppingList.items.length - 1);
      expect(res.body.items[0]._id).not.toEqual(shoppingListItemId.toString());
    });
  });
});
