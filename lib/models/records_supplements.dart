import '../source.dart';

part 'records_supplements.freezed.dart';

@freezed
class RecordsSupplements with _$RecordsSupplements {
  const factory RecordsSupplements({
    required List<Record> recordList,
    required List<Item> itemList,
  }) = _RecordsSupplements;

  factory RecordsSupplements.empty() =>
      const RecordsSupplements(recordList: [], itemList: []);
}
