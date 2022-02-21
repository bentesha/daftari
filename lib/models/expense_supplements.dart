import '../source.dart';

part 'expense_supplements.freezed.dart';

@freezed
class ExpenseSupplements with _$ExpenseSupplements {
  const factory ExpenseSupplements({
    required Map<String, String?> errors,
    required String amount,
    required DateTime date,
    String? notes,
    required String categoryId,
  }) = _ExpenseSupplements;

  factory ExpenseSupplements.empty() => ExpenseSupplements(
      errors: <String, String?>{},
      date: DateTime.now(),
      notes: null,
      categoryId: '',
      amount: '');
}
