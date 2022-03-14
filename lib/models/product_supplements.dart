import '../source.dart';

part 'product_supplements.freezed.dart';

@freezed
class ProductPageSupplements with _$ProductPageSupplements {
  const ProductPageSupplements._();

  const factory ProductPageSupplements(
      {@Default([]) List<Product> productList,
      @Default([]) List<Category> categoryList,
      @Default('') String name,
      @Default('') String categoryId,
      @Default('') String unit,
      @Default('') String unitPrice,
      @Default('') String id,
      String? code,
      @Default('') String quantity,
      @Default('') String unitValue,
      required OpeningStockItem openingStockItem,
      @Default(PageActions.viewing) PageActions action,
      @Default({}) Map<String, String?> errors}) = _ProductPageSupplements;

  factory ProductPageSupplements.empty() =>
      ProductPageSupplements(openingStockItem: OpeningStockItem.empty());

  bool get canCalculateTotalPrice =>
      double.tryParse(unitValue) != null && double.tryParse(quantity) != null;

  String get getStockValue => Utils.convertToMoneyFormat(
      double.parse(unitValue) * double.parse(quantity));

  bool get hasAddedOpeningStockDetails =>
      unitValue.isNotEmpty || quantity.isNotEmpty;

  bool get isEditing => action == PageActions.editing;

  bool get isViewing => action == PageActions.viewing;

  bool get isAdding => action == PageActions.adding;

  Product get product => Product(
      id: id,
      categoryId: categoryId,
      unit: unit,
      name: name,
      code: code,
      unitPrice: double.parse(unitPrice));
}
