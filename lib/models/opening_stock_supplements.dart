import '../source.dart';

part 'opening_stock_supplements.freezed.dart';

@freezed
class OpeningStockSupplements with _$OpeningStockSupplements {
  const OpeningStockSupplements._();

  const factory OpeningStockSupplements(
          {@Default('') String quantity,
          @Default('') String unitValue,
          @Default('') String openingStockItemId,
          @Default(PageActions.viewing) PageActions action,
          @Default({}) Map<String, String?> errors,
          String? description,
          required Product product,
          @Default([]) List<OpeningStockItem> openingStockItems}) =
      _OpeningStockSupplements;

  factory OpeningStockSupplements.empty() =>
      const OpeningStockSupplements(product: Product());

  OpeningStockItem get getOpeningStockItem {
    return OpeningStockItem(
        id: openingStockItemId,
        date: DateFormatter.convertToDMY(DateTime.now()),
        unitValue: double.parse(unitValue),
        quantity: double.parse(quantity),
        description: description,
        productId: product.id);
  }

  DateTime get date => DateTime.now();
}
