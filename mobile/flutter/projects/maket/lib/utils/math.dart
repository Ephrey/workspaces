class Math {
  static double percentage({int percent, double total}) {
    return ((percent * total) / 100).roundToDouble();
  }
}
