// ignore_for_file: constant_identifier_names
import '../source.dart';

part 'records_page_state.freezed.dart';

@freezed
class RecordsPageState with _$RecordsPageState {
  const factory RecordsPageState.loading(SalesSupplements supplements) = _Loading;
  const factory RecordsPageState.content(SalesSupplements supplements) = _Content;
  const factory RecordsPageState.success(SalesSupplements supplements) = _Success;

  factory RecordsPageState.initial() =>  RecordsPageState.content(SalesSupplements.empty());
}
