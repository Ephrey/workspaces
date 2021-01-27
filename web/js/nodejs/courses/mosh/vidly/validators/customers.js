const Joi = require('joi');

module.exports = function validateCustomer(customer) {
    const schema = Joi.object({
        name: Joi.string().min(3).max(50).required(),
        isGold: Joi.boolean().required(),
        phone: Joi.string().min(3).max(50).required(),
    });

    return schema.validate(customer);
}

