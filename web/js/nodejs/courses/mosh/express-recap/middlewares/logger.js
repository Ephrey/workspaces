function logger(req, res, next) {
    console.log('From Logger middleware : ', req.body);
    next();
}


module.exports = logger;