import '../source.dart';

part 'expense_pages_state.freezed.dart';


@freezed
class ExpensePagesState with _$ExpensePagesState {
  const factory ExpensePagesState.loading(ExpenseSupplements supplements) = _Loading;
  const factory ExpensePagesState.content(ExpenseSupplements supplements) = _Content;
  const factory ExpensePagesState.success(ExpenseSupplements supplements) = _Success;
  const factory ExpensePagesState.failed(ExpenseSupplements supplements, {String? message, @Default(false) bool showOnPage}) = _Failed;

  factory ExpensePagesState.initial() =>  ExpensePagesState.content(ExpenseSupplements.empty());
}
