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

  @HiveField(3)
  final double quantity;

  @HiveField(4)
  final double unitValue;

  OpeningStockItem(
      {required this.id,
      required this.date,
      required this.product,
      required this.unitValue,
      required this.quantity});

  factory OpeningStockItem.empty() => OpeningStockItem(
      id: '',
      date: DateTime.now(),
      product: const Product(),
      quantity: 0,
      unitValue: 0);

  OpeningStockItem copyWith({DateTime? date, Product? product}) =>
      OpeningStockItem(
          id: id,
          date: date ?? this.date,
          product: product ?? this.product,
          unitValue: unitValue,
          quantity: quantity);

  double get totalValue => unitValue * quantity;
}
