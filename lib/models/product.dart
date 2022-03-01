import '../source.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  final double unitPrice;

  @HiveField(5)
  final String categoryId;

  @HiveField(6)
  final String barcode;

  Product(
      {required this.id,
      required this.name,
      required this.unit,
      required this.unitPrice,
      required this.categoryId,
      required this.barcode});

  factory Product.empty() => Product(
      name: '', id: '', unit: 'ea.', unitPrice: 0, barcode: '', categoryId: '');

  String get getUnitPrice => Utils.convertToMoneyFormat(unitPrice);

  Product copyWith(
      {String? id,
      String? name,
      String? unit,
      double? unitPrice,
      String? categoryId,
      String? barcode,
      double? quantity}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        unitPrice: unitPrice ?? this.unitPrice,
        barcode: barcode ?? this.barcode,
        categoryId: categoryId ?? this.categoryId);
  }
}
