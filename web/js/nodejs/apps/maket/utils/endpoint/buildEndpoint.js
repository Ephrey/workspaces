/**
 *
 * @param {String} endpoint Main endpoint. eg: /api/items/
 * @param {Array} params Require params in the endpoint eg: /:id/key/:id
 * @param {Map} queries An object representing the query string. eg: {key: value, key: value}
 */
module.exports = (endpoint, params = [], queries = {}) => {
  const hasQueryString = Object.keys(queries).length > 0;

  let queryString = "";

  let paramsString = params
    ? params.join("/") + (hasQueryString ? "?" : "")
    : "";

  if (hasQueryString) {
    Object.keys(queries).forEach((key) => {
      queryString += key + "=" + queries[key] + "&";
    });

    queryString = queryString.substr(0, queryString.length - 1);
  }

  return endpoint + paramsString + queryString;
};
