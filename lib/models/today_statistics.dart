import 'package:inventory_management/source.dart';

class TodayStatistics {
  final String date;
  final double sales, purchases, expenses;
  const TodayStatistics({
    this.sales = 0.0,
    this.purchases = 0.0,
    this.expenses = 0.0,
    this.date = "",
  });

  String get formattedSales => Utils.convertToMoneyFormat(sales);

  String get formattedPurchases => Utils.convertToMoneyFormat(purchases);

  String get formattedExpenses => Utils.convertToMoneyFormat(expenses);
}
