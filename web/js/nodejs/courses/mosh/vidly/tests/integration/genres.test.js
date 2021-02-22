const request = require("supertest");
const mongoose = require("mongoose");
const { GenreModel } = require("../../models/genres");
const UserModel = require("../../models/users");

describe("/api/genres", () => {
  let server;
  let token;
  let genreName;

  beforeEach(() => {
    server = require("../../index");
    token = new UserModel().generateAuthToken();
    genreName = "genre1";
  });

  afterEach(async () => {
    await GenreModel.deleteMany({});
    await server.close();
  });

  describe("GET /", () => {
    it("should return all genres", async () => {
      await GenreModel.collection.insertMany([
        { name: "Genre1" },
        { name: "Genre2" },
      ]);

      const res = await request(server).get("/api/genres");

      expect(res.status).toEqual(200);
      expect(res.body.length).toBe(2);
      expect(res.body.some((genre) => genre.name === "Genre1")).toBeTruthy();
      expect(res.body.some((genre) => genre.name === "Genre2")).toBeTruthy();
    });
  });

  describe("GET /id", () => {
    it("should return a genre if valid id is passed", async () => {
      const genre = new GenreModel({ name: "genre1" });
      await genre.save();

      const res = await request(server).get("/api/genres/" + genre._id);

      expect(res.status).toBe(200);
      expect(res.body).toHaveProperty("name", genre.name);
    });

    it("should return 400 if invalid ID is passed", async () => {
      const res = await request(server).get("/api/genres/1");

      expect(res.status).toBe(400);
    });

    it("should return a 404 if no genre with the given ID exist", async () => {
      const id = mongoose.Types.ObjectId().toHexString();
      const res = await request(server).get("/api/genres/" + id);
      expect(res.status).toBe(404);
    });
  });

  describe("POST /", () => {
    const exec = async () => {
      return await request(server)
        .post("/api/genres")
        .set("x-auth-token", token)
        .send({ name: genreName });
    };

    it("should return 401 if client is not logged in", async () => {
      token = "";
      const res = await exec();
      expect(res.status).toBe(401);
    });

    it("should return 400 if genre is less than 5 characters", async () => {
      genreName = "1";
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should return 400 if genre is more than 50 characters", async () => {
      genreName = new Array(52).join("a");
      const res = await exec();
      expect(res.status).toBe(400);
    });

    it("should save the genre if it is valid", async () => {
      await exec();
      const genre = await GenreModel.find({ name: genreName });
      expect(genre).not.toBeNull();
    });

    it("should return the genre if it is valid", async () => {
      const res = await exec();
      expect(res.body).toHaveProperty("_id");
      expect(res.body).toHaveProperty("name", "genre1");
    });
  });
});
