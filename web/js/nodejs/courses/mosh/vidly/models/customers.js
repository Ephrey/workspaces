const mongoose = require('mongoose');

module.exports = mongoose.model('Customer', new mongoose.Schema({
    name: {
        type: String,
        minlength: 3,
        maxlength: 50,
        trim: true,
        required: true
    },
    isGold: {
        type: Boolean,
        default: false
    },
    phone: {
        type: String,
        minlength:3,
        maxlength: 50,
        trim: true,
        required: true,
    }
}));