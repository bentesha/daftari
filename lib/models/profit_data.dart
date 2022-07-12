class ProfitData {
  final double totalGrossMargin, totalExpenses, totalStockWriteOffs;

  const ProfitData({
    this.totalExpenses = 0.0,
    this.totalGrossMargin = 0.0,
    this.totalStockWriteOffs = 0.0,
  });

  double get getProfit =>
      totalGrossMargin - totalStockWriteOffs - totalExpenses;

  bool get isProfit => !getProfit.isNegative;
}
