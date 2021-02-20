const winston = require("winston");
// require("winston-mongodb");

module.exports = winston.createLogger({
  transports: [
    new winston.transports.File({
      filename: "logfile.log",
      handleExceptions: true,
    }),
    // new winston.transports.MongoDB({
    //   db: "mongodb://localhost/vidly",
    //   options: {
    //     useUnifiedTopology: true,
    //   },
    // }),
    new winston.transports.Console({
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.simple()
      ),
    }),
  ],
});
