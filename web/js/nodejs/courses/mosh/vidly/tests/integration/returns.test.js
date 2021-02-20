const moment = require("moment");
const RentalModel = require("../../models/rentals");
const UserModel = require("../../models/users");
const { CustomerModel } = require("../../models/customers");
const MovieModel = require("../../models/movies");
const mongoose = require("mongoose");
const request = require("supertest");

describe("/api/returns", () => {
  let server;

  let customerId;
  let movieId;
  let rental;
  let movie;
  let token;

  beforeEach(async () => {
    server = require("../../index");

    token = new UserModel().generateAuthToken();

    customerId = mongoose.Types.ObjectId();
    movieId = mongoose.Types.ObjectId();

    movie = new MovieModel({
      _id: movieId,
      title: "Movie title",
      dailyRentalRate: 2,
      genre: { name: "1234" },
      numberInStock: 10,
    });

    await movie.save();

    rental = new RentalModel({
      customer: new CustomerModel({
        _id: customerId,
        name: "Ephraim",
        phone: "123456",
      }),
      movie: {
        _id: movie._id,
        title: movie.title,
        dailyRentalRate: movie.dailyRentalRate,
      },
    });

    await rental.save();
  });

  afterEach(async () => {
    await RentalModel.deleteMany();
    await MovieModel.deleteMany();
    await server.close();
  });

  const exec = () => {
    return request(server)
      .post("/api/returns")
      .set("x-auth-token", token)
      .send({ customerId, movieId });
  };

  it("should return 401 if client is not logged in", async () => {
    token = "";
    const res = await exec();
    expect(res.status).toBe(401);
  });

  it("should return 400 if customerId is not provided", async () => {
    customerId = "";
    const res = await exec();
    expect(res.status).toBe(400);
  });

  it("should return 400 if movieId is not provided", async () => {
    movieId = "";
    const res = await exec();
    expect(res.status).toBe(400);
  });

  it("should return 404 if no rental found for this customer/movie", async () => {
    await RentalModel.deleteMany({});
    const res = await exec();
    expect(res.status).toBe(404);
  });

  it("should return 400 if rental already processed", async () => {
    await RentalModel.updateOne(
      { "customer._id": customerId, "movie._id": movieId },
      { dateReturn: new Date() }
    );
    const res = await exec();
    expect(res.status).toBe(400);
  });

  it("should return 200 if valid request", async () => {
    const res = await exec();
    expect(res.status).toBe(200);
  });

  it("should set the dateReturn if input is valid", async () => {
    await exec();
    const rentalInDb = await RentalModel.findById(rental._id);
    const diff = new Date() - rentalInDb.dateReturn;
    expect(diff).toBeLessThan(10 * 1000);
  });

  it("should calculate the rental fee", async () => {
    rental.dateOut = moment().add(-7, "days").toDate();
    await rental.save();

    await exec();

    const rentalInDb = await RentalModel.findById(rental._id);
    expect(rentalInDb.rentalFee).toBe(14);
  });

  it("should increase the movie stock", async () => {
    await exec();
    const moveInDb = await MovieModel.findById(movie._id);
    expect(moveInDb.numberInStock).toBe(movie.numberInStock + 1);
  });

  it("should return the rental if input is valid", async () => {
    const res = await exec();

    expect(Object.keys(res.body)).toEqual(
      expect.arrayContaining([
        "dateOut",
        "dateReturn",
        "rentalFee",
        "customer",
        "movie",
      ])
    );
  });
});
