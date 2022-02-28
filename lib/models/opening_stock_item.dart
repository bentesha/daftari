import '../source.dart';

part 'opening_stock_item.g.dart';

@HiveType(typeId: 6)
class OpeningStockItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final Product product;

  @HiveField(4)
  final double quantity;

  OpeningStockItem(
      {required this.id,
      required this.date,
      required this.product,
      required this.quantity});

  factory OpeningStockItem.empty() => OpeningStockItem(
      id: '', date: DateTime.now(), product: Product.empty(), quantity: 0);

  OpeningStockItem copyWith({DateTime? date, Product? product}) =>
      OpeningStockItem(
          id: id,
          date: date ?? this.date,
          product: product ?? this.product,
          quantity: quantity);

  double get value => product.unitPrice * quantity;
}
