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
}
