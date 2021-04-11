import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  CalculatorBrain({this.height, this.weight});

  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow((height / 100), 2);
    return _bmi.roundToDouble().toString();
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You\'ve a higher than normal body weight. Try exercise more.';
    } else if (_bmi > 18.5) {
      return 'You\'ve a normal body weight. Good job !';
    } else {
      return 'You\'ve a lower than normal body weight. You can eat a bit more';
    }
  }
}
