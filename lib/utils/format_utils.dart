import 'package:intl/intl.dart';

class FormatUtils {
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static String getFormattedDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String getCorrectFormat(String inputString) {
    final date = _dateFormat.parse(inputString);
    return _dateFormat.format(date);
  }

  static String formatWithCustomFormatter(
      String inputString, DateFormat format) {
    final date = _dateFormat.parse(inputString);
    return format.format(date);
  }

  static String formatToQuarters(String inputString) {
    final date = _dateFormat.parse(inputString);
    final year = date.year;
    final month = date.month;
    if (month == 4) return 'Q1, $year';
    if (month == 8) return 'Q2, $year';
    if (month == 12) return 'Q3, $year';
    return 'Q4, $year';
  }
}
