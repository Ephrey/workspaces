class TimeFactory {
  static uctDate() {
    var utc = new Date();
    utc.setHours(utc.getHours() + 2);
    return utc;
  }
}

module.exports = TimeFactory;
