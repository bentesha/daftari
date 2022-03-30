import '../source.dart';

part 'freezed_models/expense_supplements.freezed.dart';

@freezed
class ExpenseSupplements with _$ExpenseSupplements {
  const ExpenseSupplements._();

  const factory ExpenseSupplements(
      {@Default([]) List<Document> documents,
      //for editing expenses document
      required Document document,
      required DateTime date,
      @Default(true) bool isDateAsTitle,
      //for editing expenses
      @Default('') String amount,
      @Default('') String expenseId,
      String? description,
      required Category category,
      //for both
      @Default(PageActions.viewing) PageActions action,
      @Default({}) Map<String, String?> errors}) = _ExpenseSupplements;

  factory ExpenseSupplements.empty() => ExpenseSupplements(
      document: Document.empty(),
      category: const Category(),
      date: DateTime.now());

  List<Expense> get getExpenseList {
    final list =
        document.maybeWhen(expenses: (_, e) => e, orElse: () => <Expense>[]);
    //list is a unmodified list, doing this b'se list are mutable
    final expenseList = List.from(list).whereType<Expense>().toList();
    return expenseList;
  }

  double get parsedAmount => double.parse(amount);
}
