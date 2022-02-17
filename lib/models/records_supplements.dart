import '../source.dart';

part 'records_supplements.freezed.dart';

@freezed
class RecordsSupplements with _$RecordsSupplements {
  const factory RecordsSupplements({
    required List<Record> recordList,
    required List<Product> productList,
    required Map<String, String?> errors,
    required String quantity,
    required DateTime date,
    String? notes,
    required String sellingPrice,
    required String productId,
    required String groupId,
  }) = _RecordsSupplements;

  factory RecordsSupplements.empty() => RecordsSupplements(
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
