import '../source.dart';

class ExpensesPagesBloc extends Cubit<ExpensePagesState> {
  ExpensesPagesBloc(this.expensesService, this.categoriesService)
      : super(ExpensePagesState.initial()) {
    expensesService.addListener(_handleDocumentUpdates);
    categoriesService.addListener(_handleCategoryUpdates);
  }

  ExpensesPagesBloc.empty()
      : categoriesService = CategoriesService(),
        expensesService = ExpensesService(),
        super(ExpensePagesState.initial());

  final ExpensesService expensesService;
  final CategoriesService categoriesService;
  var _page = Pages.expense_page;

  Category getCategoryById(String id) => categoriesService.getById(id)!;

  bool get documentHasUnsavedChanges => expensesService.hasChanges;

  void init(Pages page,
      {Document? document, Expense? expense, PageActions? action}) async {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    _page = page;

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initExpensesDocumentsPage(page);
    _initDocumentExpensesPage(page, document);
    _initExpensePage(page, expense, action);
  }

  void saveDocument() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ExpensePagesState.loading(supp));

    var document = supp.document;
    var form = document.form;
    final now = DateTime.now();

    form = document.form.copyWith(
        date: now.millisecondsSinceEpoch.toString(),
        title:
            supp.isDateAsTitle ? DateFormatter.convertToDMY(now) : form.title);
    final expenseList = expensesService.getTemporaryList;
    document = Document.expenses(form, expenseList);

    try {
      await expensesService.addDocument(document);
      emit(ExpensePagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void editDocument([bool fromQuickActions = false]) async {
    _validate(true, fromQuickActions);

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(ExpensePagesState.loading(supp));

    var document = supp.document;
    if (fromQuickActions) {
      final expensesList = List<Expense>.from(
          document.maybeWhen(expenses: (_, list) => list, orElse: () => []));
      expensesList.add(Expense.toServer(
          id: Utils.getRandomId(),
          categoryId: supp.category.id,
          amount: supp.parsedAmount,
          description: supp.description));
      document = Document.expenses(document.form, expensesList);
    }
    if (supp.isDateAsTitle) {
      final form =
          document.form.copyWith(title: DateFormatter.convertToDMY(supp.date));
      document = document.copyWith(form: form);
    }

    try {
      await expensesService.editDocument(document);
      emit(ExpensePagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    try {
      await expensesService.deleteDocument(supp.document.form.id);
      emit(ExpensePagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void addExpense() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final expense = Expense.toServer(
        id: Utils.getRandomId(),
        categoryId: supp.category.id,
        amount: supp.parsedAmount,
        description: supp.description);

    expensesService.addItemTemporarily(expense);
    emit(ExpensePagesState.success(supp));
  }

  void editExpense() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final expense = Expense.toServer(
        id: supp.expenseId,
        categoryId: supp.category.id,
        amount: supp.parsedAmount,
        description: supp.description);

    expensesService.editTemporaryItem(expense);
    emit(ExpensePagesState.success(supp));
  }

  void deleteExpense() {
    var supp = state.supplements;
    expensesService.deleteTemporaryItem(supp.expenseId);
    emit(ExpensePagesState.success(supp));
  }

  void _updateAttributes(
      {String? title,
      DateTime? date,
      bool? isDateAsTitle,
      String? description,
      String? amount,
      Document? document,
      PageActions? action,
      String? documentDescription}) {
    var supp = state.supplements;

    emit(ExpensePagesState.loading(supp));
    var form = supp.document.form;
    form = form.copyWith(
        title: title ?? form.title,
        description: documentDescription ?? form.description);
    supp = supp.copyWith(
        document: document ?? supp.document.copyWith(form: form),
        amount: amount ?? supp.amount,
        description: description ?? supp.description,
        date: date ?? supp.date,
        action: action ?? supp.action,
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(ExpensePagesState.content(supp));
  }

  void clearChanges() {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
    expensesService.clearTemporaryList();
    emit(ExpensePagesState.success(supp));
  }

  _validateSalesDetails() => _validate(false);

  _validate(
      [bool isValidatingDocumentDetails = true,
      bool fromQuickActions = false]) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));

    final form = supp.document.form;
    final errors = <String, String?>{};
    if (isValidatingDocumentDetails && (!supp.isDateAsTitle)) {
      errors['title'] = InputValidation.validateText(form.title, 'Title');
    }
    if (fromQuickActions) {
      errors['document'] = InputValidation.validateText(form.title, 'Document');
    }
    //validating expense details
    if (!isValidatingDocumentDetails || fromQuickActions) {
      errors['category'] =
          InputValidation.validateText(supp.category.id, 'Category');
      errors['amount'] = InputValidation.validateNumber(supp.amount, 'Amount');
    }
    supp = supp.copyWith(errors: errors);
    emit(ExpensePagesState.content(supp));
  }

  _handleDocumentUpdates() {
    emit(ExpensePagesState.loading(state.supplements));
    _updateExpenseDocumentsPage();
    _updateDocumentExpensesPage();
  }

  _updateExpenseDocumentsPage() {
    if (_page != Pages.expenses_documents_page) return;
    final supp = state.supplements.copyWith(documents: expensesService.getList);
    emit(ExpensePagesState.content(supp));
  }

  _updateDocumentExpensesPage() {
    if (_page != Pages.document_expenses_page) return;
    var supp = state.supplements;
    final temporaryExpenses = expensesService.getTemporaryList;
    final document = Document.expenses(supp.document.form, temporaryExpenses);
    supp = supp.copyWith(document: document);
    emit(ExpensePagesState.content(supp));
  }

  ///updates the chosen product on the sales page
  _handleCategoryUpdates() {
    if (_page != Pages.expense_page) return;
    final category = categoriesService.getCurrent;
    final supp = state.supplements.copyWith(category: category);
    emit(ExpensePagesState.content(supp));
  }

  void _initExpensesDocumentsPage(Pages page) {
    if (page != Pages.expenses_documents_page) return;
    var supp = state.supplements;
    final documents = expensesService.getList;
    supp = supp.copyWith(documents: documents);
    emit(ExpensePagesState.content(supp));
  }

  void _initDocumentExpensesPage(Pages page, [Document? document]) {
    if (page != Pages.document_expenses_page) return;

    var supp = state.supplements;
    if (document == null) {
      //is adding new document
      supp = supp.copyWith(action: PageActions.adding);
    } else {
      //is viewing / editing existing document
      final form = document.form;
      final isDateAsTitle =
          _checkIfDateIsUsedAsTitle(form.title, form.dateTime);
      supp = supp.copyWith(
          document: document,
          date: form.dateTime,
          isDateAsTitle: isDateAsTitle,
          action: PageActions.viewing);
    }
    expensesService.initDocument(supp.document);
    emit(ExpensePagesState.content(supp));
  }

  bool _checkIfDateIsUsedAsTitle(String title, DateTime date) {
    final dateFromTitle = DateFormatter.convertToDMY(date);
    return title == dateFromTitle;
  }

  void _initExpensePage(Pages page, [Expense? expense, PageActions? action]) {
    if (page != Pages.expense_page) return;
    var supp = state.supplements;

    //action can't be null on the sales edit page.
    supp = supp.copyWith(action: action!);

    if (expense != null) {
      //is viewing / editing existing sales record
      final category = categoriesService.getById(expense.categoryId)!;
      supp = supp.copyWith(
          category: category,
          expenseId: expense.id,
          amount: expense.amount.toString(),
          description: expense.description);
    }
    emit(ExpensePagesState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await categoriesService.init();
      await expensesService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(ExpensePagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void updateAmount(String amount) => _updateAttributes(amount: amount);

  void updateNotes(String description) =>
      _updateAttributes(description: description);

  void updateDescription(String description) =>
      _updateAttributes(description: description);

  void updateDocumentDescription(String description) =>
      _updateAttributes(documentDescription: description);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateTitle(String title) => _updateAttributes(title: title);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes(isDateAsTitle: isDateAsTitle);

  void updateDocument(Document? document) =>
      _updateAttributes(document: document);

  void _handleError(var error) {
    final message = getErrorMessage(error);
    emit(ExpensePagesState.failed(state.supplements, message: message));
  }
}
