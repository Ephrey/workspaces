const mongoose = require('mongoose');

const customerSchema = new mongoose.Schema({
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
});

const CustomerModel = mongoose.model('Customer', customerSchema);

module.exports.CustomerModel = CustomerModel;
module.exports.customerSchema = customerSchema;