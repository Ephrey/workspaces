import 'package:maket/utils/numbers.dart';

class Date {
  static const List<String> monthsThreeLetter = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String humanReadable({String date}) {
    DateTime _parsedDate = _parseDate(date: date);

    String _day = _twoDigit(digit: _parsedDate.day);
    String _month = _twoDigit(digit: _parsedDate.month);

    return '${_parsedDate.year}/$_month/$_day';
  }

  String listTileDate({String date}) {
    DateTime _date = _parseDate(date: date);
    String _month = monthsThreeLetter[_date.month - Numbers.one];
    return '${_twoDigit(digit: _date.day)} $_month';
  }

  static DateTime _parseDate({String date}) {
    return DateTime.parse(date);
  }

  static String _twoDigit({int digit}) {
    return (digit > Numbers.nine) ? '$digit' : '0$digit';
  }
}
