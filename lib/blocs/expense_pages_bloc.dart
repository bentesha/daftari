import '../source.dart';

class ExpensePagesBloc extends Cubit<ExpensePagesState>
    with ServicesInitializer {
  ExpensePagesBloc(
      this.expensesService, this.categoriesService, this.groupsService)
      : super(ExpensePagesState.initial()) {
    categoriesService.addListener(() => _handleCategoryUpdates());
    expensesService.addListener(() => _handleExpenseUpdates());
    groupsService.addListener(() => _handleGroupUpdates());
  }

  final ExpensesService expensesService;
  final CategoriesService categoriesService;
  final GroupsService groupsService;

  double? getAmountByGroup(String id) => expensesService.getDayTotalAmounts[id];
  Category? getCategoryById(String id) => categoriesService.getCategoryById(id);

  String? _groupId;

  void init([Expense? expense, String? groupId]) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    initServices(
        expensesService: expensesService,
        categoriesService: categoriesService,
        groupsService: groupsService);

    var expenses = expensesService.getList;
    if (groupId != null) {
      _groupId = groupId;
      log('I was given the group id');
      final group = groupsService.getGroupById(groupId);
      log('hello');
      log(group!.id);
      log('hello there');
      supp = supp.copyWith(group: group);
      expenses = expenses.where((e) => e.groupId == groupId).toList();
    }

    final categories = categoriesService.getCategoryList
        .where((e) => e.type == CategoryType.expenses().name)
        .toList();
    final groups = groupsService.getList
        .where((e) => e.type == GroupType.expenses)
        .toList();

    supp = supp.copyWith(
        expenses: expenses, categories: categories, groups: groups);
    if (expense != null) {
      final category = categoriesService.getCategoryById(expense.categoryId);
      final group = groupsService.getGroupById(expense.groupId);
      supp = supp.copyWith(
          amount: expense.amount.toString(),
          id: expense.id,
          group: group!,
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
        groupId: supp.group.id,
        amount: double.parse(supp.amount),
        date: DateTime.now(),
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
        groupId: supp.group.id,
        id: supp.id);
    expensesService.edit(expense);
    emit(ExpensePagesState.success(supp));
  }

  void updateAmount(String amount) => _updateAttributes(amount: amount);

  void updateTitle(String title) => _updateAttributes(title: title);

  void updateNotes(String notes) => _updateAttributes(notes: notes);

  void updateGroupDate(DateTime date) => _updateAttributes(groupDate: date);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void _updateAttributes(
      {String? amount,
      String? notes,
      DateTime? groupDate,
      String? title,
      DateTime? date}) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    supp = supp.copyWith(
        notes: supp.notes,
        group: supp.group.copyWith(title: title, date: date),
        amount: amount ?? supp.amount,
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

  void saveGroup() {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;
    emit(ExpensePagesState.loading(supp));
    groupsService.add(supp.group);
    emit(ExpensePagesState.content(supp));
  }

  void editGroup() {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;
    emit(ExpensePagesState.loading(supp));
    groupsService.edit(supp.group);
    emit(ExpensePagesState.content(supp));
  }

  _validateGroupDetails() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));

    final errors = <String, String?>{};
    errors['title'] = InputValidation.validateText(supp.group.title, 'Title');
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
    supp = supp.copyWith(expenses: expenses);
    emit(ExpensePagesState.content(supp));
  }

  _handleGroupUpdates() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    var groups = groupsService.getList
        .where((e) => e.type == GroupType.expenses)
        .toList();

    supp = supp.copyWith(groups: groups);
    emit(ExpensePagesState.content(supp));
  }
}
