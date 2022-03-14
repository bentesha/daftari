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
      //for editing product-items
      required Product product,
      @Default('') String unitPrice,
      @Default({}) Map<String, String?> errors,
      //for opening stock item
      @Default('') String quantity,
      @Default('') String unitValue,
      required OpeningStockItem openingStockItem}) = _ProductPageSupplements;

  factory ProductPageSupplements.empty() => ProductPageSupplements(
      openingStockItem: OpeningStockItem.empty(), product: const Product());

  bool get canCalculateTotalPrice =>
      double.tryParse(unitValue) != null && double.tryParse(quantity) != null;

  String get getStockValue => Utils.convertToMoneyFormat(
      double.parse(unitValue) * double.parse(quantity));

  bool get hasAddedOpeningStockDetails =>
      unitValue.isNotEmpty || quantity.isNotEmpty;

  bool get isEditing => action == PageActions.editing;

  bool get isViewing => action == PageActions.viewing;

  bool get isAdding => action == PageActions.adding;

  Product get getProduct => Product(
      id: product.id,
      categoryId: product.categoryId,
      unit: product.unit,
      name: product.name,
      code: product.code,
      unitPrice: double.parse(unitPrice));
}
