import '../source.dart';

part 'item_supplements.freezed.dart';

@freezed
class ItemSupplements with _$ItemSupplements {
  const ItemSupplements._();

  const factory ItemSupplements(
      {required List<Item> itemList,
      required String title,
      required String categoryId,
      required String unit,
      required String unitPrice,
      required String id,
      required String query,
      required String barcode,
      required String quantity,
      required Map<String, String?> errors}) = _ItemSupplements;

  factory ItemSupplements.empty() => const ItemSupplements(
        title: '',
        query: '',
        errors: {},
        quantity: '',
        unit: '',
        barcode: '',
        id: '',
        categoryId: '',
        unitPrice: '',
        itemList: [],
      );

  bool get canCalculateTotalPrice =>
      double.tryParse(unitPrice) != null && double.tryParse(quantity) != null;

  String get getQuantityValue => Utils.convertToMoneyFormat(
      double.parse(unitPrice) * double.parse(quantity));
}
