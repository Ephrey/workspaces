const { BASE_ENDPOINT } = require("../../utils/constants/common");

module.exports = Object.freeze({
  USER_ENDPOINT: BASE_ENDPOINT + "user/",
  USER_NAME_MIN_LENGTH: 3,
  USER_NAME_MAX_LENGTH: 255,
  USER_PASSWORD_MIN_LENGTH: 8,
});
