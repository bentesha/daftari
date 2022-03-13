import '../source.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product(
      {required String id,
      required String name,
      required String unit,
      required double unitPrice,
      required String categoryId,
      required String code}) = _Product;

  factory Product.empty() => const Product(
      name: '', id: '', unit: 'ea.', unitPrice: 0, code: '', categoryId: '');

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> createJson() => {
        'name': name,
        'unit': unit,
        'unitPrice': unitPrice,
        'code': Utils.getRandomId(),
        'categoryId': categoryId
      };

  String get getUnitPrice => Utils.convertToMoneyFormat(unitPrice);
}
