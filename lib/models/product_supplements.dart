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
      required String unitValue,
      required OpeningStockItem openingStockItem,
      required Map<String, String?> errors}) = _ProductPageSupplements;

  factory ProductPageSupplements.empty() => ProductPageSupplements(
        name: '',
        errors: {},
        quantity: '',
        unit: '',
        barcode: '',
        id: '',
        categoryId: '',
        unitPrice: '',
        unitValue: '',
        productList: [],
        categoryList: [],
        openingStockItem: OpeningStockItem.empty(),
      );

  bool get canCalculateTotalPrice =>
      double.tryParse(unitValue) != null && double.tryParse(quantity) != null;

  String get getStockValue => Utils.convertToMoneyFormat(
      double.parse(unitValue) * double.parse(quantity));

  bool get hasAddedOpeningStockDetails =>
      unitValue.isNotEmpty || quantity.isNotEmpty;
}
