import '../source.dart';

part 'product_supplements.freezed.dart';

@freezed
class ProductPageSupplements with _$ProductPageSupplements {
  const ProductPageSupplements._();

  const factory ProductPageSupplements(
      {
      //for products page
      @Default([]) List<Product> productList,
      @Default([]) List<Category> categoryList,
      //for product page,
      @Default(PageActions.viewing) PageActions action,
      required Product product,
      @Default('') String unitPrice,
      @Default({}) Map<String, String?> errors,
      //for opening stock item
      @Default('') String quantity,
      @Default('') String unitValue,
      String? description}) = _ProductPageSupplements;

  factory ProductPageSupplements.empty() =>
      const ProductPageSupplements(product: Product());

  bool get canCalculateTotalPrice =>
      double.tryParse(unitValue) != null && double.tryParse(quantity) != null;

  String get getStockValue => Utils.convertToMoneyFormat(
      double.parse(unitValue) * double.parse(quantity));

  double get parsedUnitValue => double.parse(unitValue);

  double get parsedQuantity => double.parse(quantity);

  DateTime get date => DateTime.now();

  bool get hasAddedOpeningStockDetails =>
      unitValue.isNotEmpty || quantity.isNotEmpty;

  Product get getProduct => Product(
      id: product.id,
      categoryId: product.categoryId,
      unit: product.unit,
      name: product.name,
      code: product.code,
      unitPrice: double.parse(unitPrice));
}
