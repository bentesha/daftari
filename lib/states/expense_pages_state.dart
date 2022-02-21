import '../source.dart';

part 'expense_pages_state.freezed.dart';


@freezed
class ExpensePagesState with _$ExpensePagesState {
  const factory ExpensePagesState.loading(RecordsSupplements supplements) = _Loading;
  const factory ExpensePagesState.content(RecordsSupplements supplements) = _Content;
  const factory ExpensePagesState.success(RecordsSupplements supplements) = _Success;

  factory ExpensePagesState.initial() =>  ExpensePagesState.content(RecordsSupplements.empty());
}
