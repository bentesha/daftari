import '../source.dart';

part 'records_supplements.freezed.dart';

@freezed
class RecordsSupplements with _$RecordsSupplements {
  const factory RecordsSupplements({
    required List<Record> recordList,
    required List<Item> itemList,
    required Map<String, String?> errors,
    required String quantity,
    required DateTime date,
    String? notes,
    required String amount,
    required String selectedItemId,
    required String query,
  }) = _RecordsSupplements;

  factory RecordsSupplements.empty() => RecordsSupplements(
      recordList: [],
      itemList: [],
      errors: <String, String?>{},
      date: DateTime.now(),
      notes: null,
      selectedItemId: '',
      amount: '',
      query: '',
      quantity: '');
}
