import 'package:inventory_management/source.dart';

class DateFormatter {
  static final monthsList = [
    'January',
    'February',
    'March',
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static _leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }

  static int getDaysInMonth() {
    final monthLength = <int>[31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    final date = DateTime.now();

    if (_leapYear(date.year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[date.month - 1];
  }

  static String getCurrentMonth() {
    final date = DateTime.now();
    return monthsList[date.month - 1];
  }

  static int getCurrentYear() {
    final date = DateTime.now();
    return date.year;
  }

  static String getWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
    }
    return 'Monday';
  }

  static String getOrdinalsFrom(int day) {
    var ordinal = 'th';
    final _day = day.toString();
    if (_day.endsWith('1')) ordinal = 'st';
    if (_day.endsWith('2')) ordinal = 'nd';
    if (_day.endsWith('3')) ordinal = 'rd';
    return ordinal;
  }

  static String _getMonthShortForm(int month) {
    return monthsList[month - 1].substring(0, 3);
  }

  ///converts the date to Date - Month - Year format
  static String convertToDMY(DateTime date) {
    final month = _getMonthShortForm(date.month);
    return '${date.day} $month ${date.year}';
  }
}
