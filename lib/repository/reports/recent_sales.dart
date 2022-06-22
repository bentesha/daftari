class RecentSales {
  final String productId, productName, productUnit;
  final double quantity, unitPrice, total;

  const RecentSales(
      {required this.productId,
      required this.productName,
      required this.productUnit,
      required this.quantity,
      required this.total,
      required this.unitPrice});

  factory RecentSales.fromMap(Map<String, dynamic> rawMap) {
    return RecentSales(
        productId: rawMap['Product.id'],
        productUnit: rawMap['Product.unit'],
        productName: rawMap['Product.name'],
        total: rawMap['SalesDetail.total'],
        quantity: rawMap['SalesDetail.quantity'],
        unitPrice: rawMap['SalesDetail.unitPrice']);
  }
}
