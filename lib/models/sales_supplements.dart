import '../source.dart';

part 'sales_supplements.freezed.dart';

@freezed
class SalesSupplements with _$SalesSupplements {
  const factory SalesSupplements({
    required List<Sales> recordList,
    required List<Product> productList,
    required Map<String, String?> errors,
    required String quantity,
    required DateTime date,
    String? notes,
    required String sellingPrice,
    required String productId,
    required String groupId,
  }) = _SalesSupplements;

  factory SalesSupplements.empty() => SalesSupplements(
      recordList: [],
      productList: [],
      errors: <String, String?>{},
      date: DateTime.now(),
      notes: null,
      productId: '',
      groupId: '',
      sellingPrice: '',
      quantity: '');
}
