import '../source.dart';

part 'product_supplements.freezed.dart';

@freezed
class ProductPageSupplements with _$ProductPageSupplements {
  const ProductPageSupplements._();

  const factory ProductPageSupplements(
      {required List<Product> productList,
      required List<Category> categoryList,
      required String name,
      required String categoryId,
      required String unit,
      required String unitPrice,
      required String id,
      required String barcode,
      required String quantity,
      required Map<String, String?> errors}) = _ProductPageSupplements;

  factory ProductPageSupplements.empty() => const ProductPageSupplements(
        name: '',
        errors: {},
        quantity: '',
        unit: '',
        barcode: '',
        id: '',
        categoryId: '',
        unitPrice: '',
        productList: [],
        categoryList: [],
      );

  bool get canCalculateTotalPrice =>
      double.tryParse(unitPrice) != null && double.tryParse(quantity) != null;

  String get getQuantityValue => Utils.convertToMoneyFormat(
      double.parse(unitPrice) * double.parse(quantity));
}
