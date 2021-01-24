const express = require('express');
const router = express.Router();



// GET 
router.get('/', (req, res) => {
    res.render('index', {title: "My Express App", message: "Welcome :) Reformatted ..."})
    // res.send('Hello, world :)');
});

module.exports = router;