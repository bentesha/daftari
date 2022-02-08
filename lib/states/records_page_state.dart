import '../source.dart';

part 'records_page_state.freezed.dart';

enum RecordPages { record_page, search_item_page }

@freezed
class RecordsPageState with _$RecordsPageState {
  const factory RecordsPageState.loading(RecordsSupplements supplements) = _Loading;
  const factory RecordsPageState.content(RecordsSupplements supplements) = _Content;
  const factory RecordsPageState.success(RecordsSupplements supplements, RecordPages page) = _Success;

  factory RecordsPageState.initial() =>  RecordsPageState.content(RecordsSupplements.empty());
}
