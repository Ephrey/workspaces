/**
 *
 * @param {String} endpoint main endpoint. eg: /api/items/
 * @param {Array} params require params in the endpoint eg: /:id/key/:id
 * @param {Object} queries an object representing the query string. eg: {key: value, key: value}
 */
module.exports = (endpoint, params = [], queries = {}) => {
  let queryString = "";

  let paramsString = params ? params.join("/") + (queries ? "?" : "") : "";

  if (queries) {
    Object.keys(queries).forEach((key) => {
      queryString += key + "=" + queries[key] + "&";
    });

    queryString = queryString.substr(0, queryString.length - 1);
  }

  return endpoint + paramsString + queryString;
};
