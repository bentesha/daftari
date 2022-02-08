import '../source.dart';

part 'sales_page_state.freezed.dart';

@freezed
class SalesPageState with _$SalesPageState {
  const factory SalesPageState.loading(RecordsSupplements supplements) = _Loading;
  const factory SalesPageState.content(RecordsSupplements supplements) = _Content;

  factory SalesPageState.initial() =>  SalesPageState.content(RecordsSupplements.empty());
}
