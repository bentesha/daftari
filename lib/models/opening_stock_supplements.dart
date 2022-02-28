import '../source.dart';

part 'opening_stock_supplements.freezed.dart';

@freezed
class OpeningStockSupplements with _$OpeningStockSupplements {
  const factory OpeningStockSupplements(
          {required OpeningStockItem openingStockItem,
          required String quantity,
          required String unitPrice,
          required Map<String, String?> errors,
          required List<OpeningStockItem> openingStockItems}) =
      _OpeningStockSupplements;

  factory OpeningStockSupplements.empty() => OpeningStockSupplements(
      openingStockItem: OpeningStockItem.empty(),
      quantity: '',
      unitPrice: '',
      errors: <String, String?>{},
      openingStockItems: <OpeningStockItem>[]);
}
