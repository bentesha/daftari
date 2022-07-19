class ProfitData {
  final double expenses, stockWriteOffs, sales, costOfSales;

  const ProfitData({
    this.expenses = 0.0,
    this.stockWriteOffs = 0.0,
    this.sales = 0.0,
    this.costOfSales = 0.0,
  });

  double get grossProfit => sales - costOfSales;

  double get getProfit => grossProfit - stockWriteOffs - expenses;

  bool get isProfit => !getProfit.isNegative;
}
