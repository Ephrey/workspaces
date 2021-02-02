const auth = require("../middlewares/auth");
const admin = require("../middlewares/admin");
const validateGenre = require("../validators/genres");
const { GenreModel } = require("../models/genres");
const express = require("express");
const router = express.Router();

// GET

/**
 * Get all genres
 */
router.get("/", async (req, res) => {
  res.send(await GenreModel.find({}).sort({ name: 1 }));
});

/**
 * Get a genre by its ID
 */
router.get("/:id", async (req, res) => {
  const genreId = req.params.id;

  if (genreId.length !== 24) {
    return res.status(400).send("The ID is required and must be of length 24");
  }

  try {
    const genre = await GenreModel.findById(genreId);

    if (!genre) {
      return res
        .status(404)
        .send(`The genre with ID ${genreId} does not exist`);
    }

    res.send(genre);
  } catch (err) {
    res.send(err.message);
  }
});

// POST
router.post("/", auth, async (req, res) => {
  let genre = req.body;

  const { error } = validateGenre(genre);

  if (error) {
    res.status(400).send(error.details[0].message);
    return;
  }

  genre = new GenreModel(genre);

  try {
    res.send(await genre.save());
  } catch (err) {
    res.send(err.message);
  }
});

// PUT/UPDATE
router.put("/:id", auth, async (req, res) => {
  const genreId = req.params.id;

  if (genreId.length !== 24) {
    return res.status(400).send("The ID is required and must be of length 24.");
  }

  const newGenreName = req.body;
  const { error } = validateGenre(newGenreName);

  if (error) {
    return res.status(400).send(error.details[0].message);
  }

  try {
    const oldGenre = await GenreModel.exists({ _id: genreId });

    if (!oldGenre) {
      return res
        .status(404)
        .send(`The genre with ID ${genreId} does not exist`);
    }

    const newGenre = await GenreModel.findOneAndUpdate(
      { _id: genreId },
      newGenreName,
      {
        new: true,
        useFindAndModify: false,
      }
    );

    res.send(newGenre);
  } catch (err) {
    res.send(err.message);
  }
});

// DELETE
router.delete("/:id", [auth, admin], async (req, res) => {
  const genreId = req.params.id;

  if (genreId.length !== 24) {
    return res.status(400).send("The ID is required and must be of length 24.");
  }

  try {
    const genre = await GenreModel.exists({ _id: genreId });

    if (!genre) {
      return res
        .status(404)
        .send(`The genre with ID ${genreId} does not exist`);
    }

    const deletedGenre = await GenreModel.findByIdAndRemove(genreId);
    res.send({ status: "Success", genre: deletedGenre });
  } catch (err) {
    res.send(err.message);
  }
});

module.exports = router;
