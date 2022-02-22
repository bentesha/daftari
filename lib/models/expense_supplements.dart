import '../source.dart';

part 'expense_supplements.freezed.dart';

@freezed
class ExpenseSupplements with _$ExpenseSupplements {
  const factory ExpenseSupplements(
      {required List<Expense> expenses,
      required List<Category> categories,
      required List<Group> groups,
      required Map<String, String?> errors,
      required String amount,
      required DateTime date,
      String? notes,
      required String id,
      required Group group,
      required Category category}) = _ExpenseSupplements;

  factory ExpenseSupplements.empty() => ExpenseSupplements(
      expenses: <Expense>[],
      categories: <Category>[],
      groups: <Group>[],
      errors: <String, String?>{},
      date: DateTime.now(),
      notes: null,
      category: Category.empty(),
      group: Group.empty().copyWith(type: GroupType.expenses),
      id: '',
      amount: '');
}
