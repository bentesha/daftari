import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static const _uuid = Uuid();

  static getRandomId() => _uuid.v4();

  static String convertToMoneyFormat(double number) {
    return NumberFormat.currency(symbol: '').format(number);
  }

  static String dateToString(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  static String dateRangeToString(DateTimeRange range) {
    return '${dateToString(range.start)} - ${dateToString(range.end)}';
  }
}
