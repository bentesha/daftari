import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static String dateToString(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  static String convertDateToISOFormat(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String dateRangeToString(DateTimeRange range) {
    return '${dateToString(range.start)} - ${dateToString(range.end)}';
  }

  static List<double> getRandomAmounts() {
    final amounts = <double>[];
    final random = Random();
    for (int index = 0; index < 11; index++) {
      amounts.add(random.nextDouble() * 1234500);
    }
    return amounts;
  }

  static String convertToMoneyFormat(num amount) {
    final formatter = NumberFormat.currency(symbol: '');
    return formatter.format(amount);
  }

  static String getRandomId() => const Uuid().v4();
}
