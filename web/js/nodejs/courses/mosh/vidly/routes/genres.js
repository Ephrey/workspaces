const Joi = require('joi');
const express = require('express');
const router = express.Router();


/**
 * A list of movie genres
 * 
 * @const {Object[]} genres
 */
const genres = [
    {id: 1, name: "Comedy", popular: false},
    {id: 2, name: "Fantasy"},
    {id: 3, name: "Crime"},
    {id: 4, name: "Drama"},
    {id: 5, name: "Music"},
    {id: 6, name: "Adventure"},
    {id: 7, name: "History"},
    {id: 8, name: "Thriller"},
    {id: 9, name: "Animation"},
    {id: 10, name: "Family"},
    {id: 11, name: "Mystery"},
    {id: 12, name: "Biography"},
    {id: 13, name: "Action"},
    {id: 14, name: "Film-Noir"},
    {id: 15, name: "Romance"},
    {id: 16, name: "Sci-Fi"},
    {id: 17, name: "War"},
    {id: 18, name: "Western"},
    {id: 19, name: "Horror"},
    {id: 20, name: "Musical"},
    {id: 21, name: "Sport"}
]

// GET 

/**
 * Get all genres
 */
router.get('/', (req, res) => {
    res.send(genres);
});

/**
 * Get a genre by its ID
 */
router.get('/:id', (req, res) => {
    const genreId = parseInt(req.params.id);
  
    if(!genreId) {
        return res.status(400).send('The ID must be a valid Number');
    }

    const genre = genres.find(genre => genre.id === genreId);

    if(!genre) {
        return res.status(404).send(`The genre with ID ${genreId} does not exist`);
    }

    res.send(genre);
});

// POST 
router.post('/', (req, res) => {
    const genre = req.body;

    const { error } = validateGenre(genre);

    if(error) {
        res.status(400).send(error.details[0].message);
        return;
    }

    genre.id = genres.length + 1;

    genres.push(genre);

    res.send(genre); 
});

// PUT/UPDATE
router.put('/:id', (req, res) => {
    const genreId = parseInt(req.params.id);
    const newGenre = req.body;
  
    if(!genreId) {
        return res.status(400).send('The ID must be a valid Number');
    }

    const { error } = validateGenre(newGenre);

    if(error) {
        return res.status(400).send(error.details[0].message);
    }

    const oldGenre = genres.find(genre => genre.id === genreId);

    if(!oldGenre) {
        return res.status(404).send(`The genre with ID ${genreId} does not exist`);
    }

    const oldGenreIndex = genres.indexOf(oldGenre);

    genres[oldGenreIndex].name = newGenre.name;

    res.send(genres[oldGenreIndex]);
});

// DELETE
router.delete('/:id', (req, res) => {
    const genreId = parseInt(req.params.id);
  
    if(!genreId) {
        return res.status(400).send('The ID must be a valid Number');
    }

    const genre = genres.find(genre => genre.id === genreId);

    if(!genre) {
        return res.status(404).send(`The genre with ID ${genreId} does not exist`);
    }

    genres.splice(genres.indexOf(genre), 1);

    res.send({status: "Success", genre: genre});
});



/**
 * Request Body Values Validator
 * 
 * @param {Object} genre - the genre object to be validate
 * @param {Number} genre.id - the id of the genre
 * @param {Number} genre.name - the name of the genre
 * 
 * @returns {Joi.ValidationOptions}
 */
function validateGenre(genre) {
    const schema = Joi.object({
        name: Joi.string().min(2).required()
    });

    return schema.validate(genre);
}


module.exports = router;