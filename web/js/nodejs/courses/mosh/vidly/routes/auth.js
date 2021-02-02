const Joi = require('joi');
const bcrypt = require('bcrypt');
const _ = require('lodash');
const UserModel = require('../models/users');
const express = require('express');
const router = express.Router();

const INVALID_EMAIL_AND_PASSWORD_MESSAGE = 'Invalid email or password';

router.get('/', async (req, res) => {
    res.send(await UserModel.find({}).sort({name: 1}));
});

router.post('/', async (req, res) => {
    let userCredentials = req.body;

    const { error } = validate(userCredentials);

    if(error) {
        return res.status(400).send(error.details[0].message);
    }

    try {
        const user = await UserModel.findOne({ email: userCredentials.email });
        if(!user) {
            return res.status(400).send(INVALID_EMAIL_AND_PASSWORD_MESSAGE);
        }
        
        const isValidPassword = await bcrypt.compare(userCredentials.password, user.password);

        if(!isValidPassword) {
            return res.status(400).send(INVALID_EMAIL_AND_PASSWORD_MESSAGE);
        }

        const token = user.generateAuthToken();

        res.send(token);

    }catch(err) {
        res.send(err.message);
    }
});


function validate(user) {
    const schema = Joi.object({
        email: Joi.string().min(5).max(255).email(),
        password: Joi.string().min(5).max(255),
    });

    return schema.validate(user);
}

module.exports = router;



