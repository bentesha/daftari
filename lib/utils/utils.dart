import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static const _uuid = Uuid();

  static getRandomId() => _uuid.v4();

  static String convertToMoneyFormat(double number) {
    return NumberFormat.currency(symbol: '').format(number);
  }
}
