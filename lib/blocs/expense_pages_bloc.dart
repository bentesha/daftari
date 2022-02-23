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
  Category? getCategoryById(String id) => categoriesService.getById(id);

  void init(Pages page, [Expense? expense, String? groupId]) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    initServices(
        expensesService: expensesService,
        categoriesService: categoriesService,
        groupsService: groupsService);

    _initExpensesGroupsPage(page);
    _initGroupExpensesPage(page, groupId);
    _initExpensesEditPage(page, expense, groupId);
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

  void updateGroupTitle(String title) => _updateAttributes(title: title);

  void updateNotes(String notes) => _updateAttributes(notes: notes);

  void updateGroupDate(DateTime date) => _updateAttributes(groupDate: date);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void saveGroup() async {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;
    emit(ExpensePagesState.loading(supp));
    final group = Group(
        id: Utils.getRandomId(),
        date: supp.group.date,
        title: supp.group.title,
        type: CategoryType.expenses().name);
    //copying the group-id
    supp = supp.copyWith(group: group);
    await groupsService.add(group);
    emit(ExpensePagesState.content(supp));
  }

  void editGroup() async {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;
    emit(ExpensePagesState.loading(supp));
    await groupsService.edit(supp.group);
    emit(ExpensePagesState.content(supp));
  }

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

  _validate([bool isValidatingGroupDetails = false]) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));

    final errors = <String, String?>{};

    if (isValidatingGroupDetails) {
      errors['title'] = InputValidation.validateText(supp.group.title, 'Title');
    } else {
      errors['category'] =
          InputValidation.validateText(supp.category.id, 'Category');
      errors['amount'] = InputValidation.validateNumber(supp.amount, 'Amount');
    }

    supp = supp.copyWith(errors: errors);
    emit(ExpensePagesState.content(supp));
  }

  _validateGroupDetails() => _validate(true);

  void _initExpensesGroupsPage(Pages page) {
    if (page != Pages.expenses_groups_page) return;

    var supp = state.supplements;
    final groups = groupsService.getList
        .where((e) => e.type == GroupType.expenses)
        .toList();
    final expenses = expensesService.getList;
    supp = supp.copyWith(groups: groups, expenses: expenses);
    emit(ExpensePagesState.content(supp));
  }

  void _initGroupExpensesPage(Pages page, [String? groupId]) {
    if (page != Pages.group_expenses_page) return;

    var supp = state.supplements;
    if (groupId == null) {
      //is adding new group
      supp = ExpenseSupplements.empty();
    } else {
      //is viewing existing group
      final expenses =
          expensesService.getList.where((e) => e.groupId == groupId).toList();
      final group = groupsService.getById(groupId);
      supp = supp.copyWith(expenses: expenses, group: group!);
    }
    emit(ExpensePagesState.content(supp));
  }

  void _initExpensesEditPage(Pages page, [Expense? expense, String? groupId]) {
    if (page != Pages.expense_edit_page) return;

    var supp = state.supplements;
    if (groupId != null) {
      //is adding a new expense:
      supp = ExpenseSupplements.empty();
      supp = supp.copyWith(group: supp.group.copyWith(id: groupId));
    }
    if (expense != null) {
      //is editing existing expense
      final category = categoriesService.getById(expense.categoryId);
      supp = supp.copyWith(
          group: supp.group.copyWith(id: expense.groupId),
          date: expense.date,
          amount: expense.amount.toString(),
          category: category!,
          id: expense.id,
          notes: expense.notes);
    }
    emit(ExpensePagesState.content(supp));
  }

  ///handling selected category on expense-edit-page
  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    supp = supp.copyWith(category: categoriesService.getCurrent);
    emit(ExpensePagesState.content(supp));
  }

  ///handling expenses on the group-expenses-page
  _handleExpenseUpdates() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    var expenses = expensesService.getList
        .where((e) => e.groupId == supp.group.id)
        .toList();
    supp = supp.copyWith(expenses: expenses);
    emit(ExpensePagesState.content(supp));
  }

  ///handling expense groups on the expenses-groups-page
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
