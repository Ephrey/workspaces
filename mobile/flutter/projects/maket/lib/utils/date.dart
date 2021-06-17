import 'package:maket/utils/numbers.dart';

class Date {
  String humanReadable({String date}) {
    DateTime _parsedDate = _parseDate(date: date);

    String _day = _twoDigit(digit: _parsedDate.day);
    String _month = _twoDigit(digit: _parsedDate.month);

    return '${_parsedDate.year}-$_month-$_day';
  }

  static DateTime _parseDate({String date}) {
    return DateTime.parse(date);
  }

  static String _twoDigit({int digit}) {
    return (digit > Numbers.nine) ? '$digit' : '0$digit';
  }
}
