import 'package:uuid/uuid.dart';

import '../source.dart';

extension SizeExtension on num {
  // ignore: unused_element
  double get dw => ScreenSizeConfig.getDoubleWidth(this);
  double get dh => ScreenSizeConfig.getDoubleHeight(this);
}

class Utils {
  static const _uuid = Uuid();

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

  static getRandomId() => _uuid.v4();

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
    final monthsList = [
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

  static String convertToMoneyFormat(double number) {
    final pieces = <String>[];
    String stringVersion = number.toString();
    final index = stringVersion.indexOf('.');
    final decimals = stringVersion.substring(index, stringVersion.length);
    final isNegative = stringVersion.startsWith('-');
    stringVersion = stringVersion.substring(isNegative ? 1 : 0, index);

    for (int i = 0; i < stringVersion.length / 3; i++) {
      final length = stringVersion.length;

      if (length > 3) {
        final added = stringVersion.substring(length - 3, length);
        pieces.add(added);
        stringVersion = stringVersion.substring(0, length - 3);
      }
    }

    pieces.add(stringVersion);

    if (pieces.length == 1) {
      return (isNegative ? '- ' : '') + pieces.first.toString() + '.00';
    }

    final reversedList = pieces.reversed.toList();
    String money = '';
    for (int i = 0; i < reversedList.length; i++) {
      final v = reversedList[i];
      money = i == reversedList.length - 1 ? money + v : money + v + ',';
    }

    return (isNegative ? '-' : '') +
        money +
        (decimals.length == 2 ? '${decimals}0' : decimals);
  }
}
