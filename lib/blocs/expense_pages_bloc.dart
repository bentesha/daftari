import '../source.dart';

class ExpensePagesBloc extends Cubit<ExpensePagesState>
    with ServicesInitializer {
  ExpensePagesBloc(this.expensesService, this.categoriesService)
      : super(ExpensePagesState.initial()) {
    categoriesService.addListener(() => _handleCategoryUpdates());
    expensesService.addListener(() => _handleExpenseUpdates());
  }

  final ExpensesService expensesService;
  final CategoriesService categoriesService;

  List<int> get getDaysWithExpenses => expensesService.getDaysWithExpenses();
  double? getAmountByDay(int day) => expensesService.getDayTotalAmounts[day];
  Category? getCategoryById(String id) => categoriesService.getCategoryById(id);

  int? _day;

  void init([Expense? expense, int? day]) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    initServices(
        expensesService: expensesService, categoriesService: categoriesService);
    var expenses = expensesService.getList;
    if (day != null) {
      _day = day;
      expenses = expenses.where((e) => e.date.day == day).toList();
    }

    final categories = categoriesService.getCategoryList
        .where((e) => e.type == CategoryType.expenses().name)
        .toList();
    supp = supp.copyWith(expenses: expenses, categories: categories);
    if (expense != null) {
      final category = categoriesService.getCategoryById(expense.categoryId);
      supp = supp.copyWith(
          date: expense.date,
          amount: expense.amount.toString(),
          id: expense.id,
          category: category!,
          notes: expense.notes);
    }
    emit(ExpensePagesState.content(supp));
  }

  void saveExpense() {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ExpensePagesState.loading(supp));
    final expense = Expense(
        amount: double.parse(supp.amount),
        date: supp.date,
        categoryId: supp.category.id,
        id: Utils.getRandomId());
    expensesService.add(expense);
    emit(ExpensePagesState.success(supp));
  }

  void editExpense() {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ExpensePagesState.loading(supp));
    final expense = Expense(
        amount: double.parse(supp.amount),
        date: supp.date,
        categoryId: supp.category.id,
        id: supp.id);
    expensesService.edit(expense);
    emit(ExpensePagesState.success(supp));
  }

  void updateAmount(String amount) => _updateAttributes(amount: amount);

  void updateNotes(String notes) => _updateAttributes(notes: notes);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void _updateAttributes({String? amount, String? notes, DateTime? date}) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    supp = supp.copyWith(
        amount: amount ?? supp.amount,
        notes: supp.notes,
        date: date ?? supp.date);
    emit(ExpensePagesState.content(supp));
  }

  _validate() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));

    final errors = <String, String?>{};
    errors['category'] =
        InputValidation.validateText(supp.category.id, 'Category');
    errors['amount'] = InputValidation.validateNumber(supp.amount, 'Amount');

    supp = supp.copyWith(errors: errors);
    emit(ExpensePagesState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    supp = supp.copyWith(category: categoriesService.getCurrent);
    emit(ExpensePagesState.content(supp));
  }

  _handleExpenseUpdates() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    var expenses = expensesService.getList;
    if (_day != null) {
      expenses = expenses.where((e) => e.date.day == _day).toList();
    }
    supp = supp.copyWith(expenses: expenses);
    emit(ExpensePagesState.content(supp));
  }
}
