import 'package:uuid/uuid.dart';

import '../source.dart';

extension SizeExtension on num {
  // ignore: unused_element
  double get dw => ScreenSizeConfig.getDoubleWidth(this);
  double get dh => ScreenSizeConfig.getDoubleHeight(this);
}

class Utils {
  static const _uuid = Uuid();

  static getRandomId() => _uuid.v4();

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
