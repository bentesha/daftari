enum ReportType {
  sales,
  purchases,
  expenses,
  priceList,
  remainingStock,
  profitLoss,
  inventoryMovement
}

extension ReportTypeExtension on ReportType {
  String get reportName {
    switch (this) {
      case ReportType.sales:
        return 'Sales Report';
      case ReportType.purchases:
        return 'Purchases Report';
      case ReportType.expenses:
        return 'Expenses Report';
      case ReportType.priceList:
        return 'Price List';
      case ReportType.remainingStock:
        return 'Remaining Stock Report';
      case ReportType.profitLoss:
        return 'Profit & Loss Report';
      case ReportType.inventoryMovement:
        return 'Inventory Movement Report';
      default:
    }
    throw '$this is not be defined';
  }

  String get string {
    switch (this) {
      case ReportType.sales:
        return 'Sales';
      case ReportType.purchases:
        return 'Purchases';
      case ReportType.expenses:
        return 'Expenses';
      case ReportType.priceList:
        return 'Price List';
      case ReportType.remainingStock:
        return 'Remaining Stock';
      case ReportType.profitLoss:
        return 'Profit & Loss';
      case ReportType.inventoryMovement:
        return 'Inventory Movement';
      default:
    }
    throw '$this is not be defined';
  }

  bool get isSales => this == ReportType.sales;
  bool get isPurchases => this == ReportType.purchases;
  bool get isExpenses => this == ReportType.expenses;
  bool get isPriceList => this == ReportType.priceList;
  bool get isRemainingStock => this == ReportType.remainingStock;
  bool get isProfitLoss => this == ReportType.profitLoss;
  bool get isInventoryMovement => this == ReportType.inventoryMovement;

  bool get hasFilters =>
      isExpenses ||
      isSales ||
      isPurchases ||
      isRemainingStock ||
      isInventoryMovement;

  bool get hasItsOwnImpl => isProfitLoss || isInventoryMovement;
}
