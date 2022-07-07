class RecentSale {
  final String productName;
  final double quantity, unitPrice, total;

  const RecentSale(
      {required this.productName,
      required this.quantity,
      required this.total,
      required this.unitPrice});

  factory RecentSale.fromMap(Map<String, dynamic> rawMap) {
    return RecentSale(
      productName: rawMap['product']['name'],
      total: (rawMap['total'] as num).toDouble(),
      quantity: (rawMap['quantity'] as num).toDouble(),
      unitPrice: (rawMap['product']['unitPrice'] as num).toDouble(),
    );
  }
}
