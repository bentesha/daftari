import '../source.dart';

class SalesPagesBloc extends Cubit<SalesDocumentsPageState> {
  SalesPagesBloc(this.salesService, this.productsService)
      : super(SalesDocumentsPageState.initial()) {
    salesService.addListener(_handleDocumentUpdates);
    productsService.addListener(_handleProductUpdates);
  }

  SalesPagesBloc.empty()
      : salesService = SalesService(),
        productsService = ProductsService(),
        super(SalesDocumentsPageState.initial());

  final SalesService salesService;
  final ProductsService productsService;
  var _page = Pages.sales_page;

  Product getProductById(String id) => productsService.getById(id)!;

  bool get documentHasUnsavedChanges => salesService.hasChanges;

  void init(Pages page,
      {Document? document, Sales? sales, PageActions? action}) async {
    var supp = state.supplements;
    emit(SalesDocumentsPageState.loading(supp));
    _page = page;

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initSalesDocumentsPage(page);
    _initDocumentSalesPage(page, document);
    _initSalesPage(page, sales, action);
  }

  void saveDocument() async {
    var supp = state.supplements;
    var document = supp.document;
    var form = document.form;
    final now = DateTime.now();

    form = document.form.copyWith(date: now.millisecondsSinceEpoch.toString());

    emit(SalesDocumentsPageState.loading(supp));

    final salesList = salesService.getTemporaryList;
    document = Document.sales(form, salesList);

    // checking if empty
    final documentList =
        document.maybeWhen(sales: (_, list) => list, orElse: () => []);
    if (documentList.isEmpty) {
      emit(SalesDocumentsPageState.failed(supp,
          message: 'Document can\'t be empty'));
      return;
    }

    try {
      await salesService.addDocument(document);
      emit(SalesDocumentsPageState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void editDocument() async {
    var supp = state.supplements;
    emit(SalesDocumentsPageState.loading(supp));

    var document = supp.document;
    // checking if empty
    final documentList =
        document.maybeWhen(sales: (_, list) => list, orElse: () => []);
    if (documentList.isEmpty) {
      emit(SalesDocumentsPageState.failed(supp,
          message: 'Document can\'t be empty'));
      return;
    }

    try {
      await salesService.editDocument(document);
      emit(SalesDocumentsPageState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(SalesDocumentsPageState.loading(supp));
    try {
      await salesService.deleteDocument(supp.document.form.id);
      emit(SalesDocumentsPageState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void addSales() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    log(supp.parsedQuantity.toString());

    final sales = Sales.toServer(
        id: Utils.getRandomId(),
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    salesService.addItemTemporarily(sales);
    emit(SalesDocumentsPageState.success(supp));
  }

  void editSales() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final sales = Sales.toServer(
        id: supp.salesId,
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    salesService.editTemporaryItem(sales);
    emit(SalesDocumentsPageState.success(supp));
  }

  void deleteSales() {
    var supp = state.supplements;
    salesService.deleteTemporaryItem(supp.salesId);
    emit(SalesDocumentsPageState.success(supp));
  }

  void _updateAttributes(
      {DateTime? date,
      bool? isDateAsTitle,
      String? quantity,
      String? unitPrice,
      Document? document,
      PageActions? action,
      String? description}) {
    var supp = state.supplements;

    emit(SalesDocumentsPageState.loading(supp));
    var form = supp.document.form;
    form = form.copyWith(description: description ?? form.description);
    supp = supp.copyWith(
        document: document ?? supp.document.copyWith(form: form),
        quantity: quantity ?? supp.quantity,
        unitPrice: unitPrice ?? supp.unitPrice,
        date: date ?? supp.date,
        action: action ?? supp.action,
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(SalesDocumentsPageState.content(supp));
  }

  void clearChanges() {
    var supp = state.supplements;
    emit(SalesDocumentsPageState.loading(supp));
    salesService.clearTemporaryList();
    emit(SalesDocumentsPageState.success(supp));
  }

  _validateSalesDetails() {
    var supp = state.supplements;
    emit(SalesDocumentsPageState.loading(supp));

    final errors = <String, String?>{};
    //validating sales details

    errors['product'] =
        InputValidation.validateText(supp.product.id, 'Product');
    errors['price'] = InputValidation.validateNumber(supp.unitPrice, 'Price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(SalesDocumentsPageState.content(supp));
  }

  _handleDocumentUpdates() {
    emit(SalesDocumentsPageState.loading(state.supplements));
    _updateSalesDocumentsPage();
    _updateDocumentSalesPage();
  }

  _updateSalesDocumentsPage() {
    if (_page != Pages.sales_documents_page) return;
    final supp = state.supplements.copyWith(documents: salesService.getList);
    emit(SalesDocumentsPageState.content(supp));
  }

  _updateDocumentSalesPage() {
    if (_page != Pages.document_sales_page) return;
    var supp = state.supplements;
    final temporarySales = salesService.getTemporaryList;
    final total = salesService.temporarySalesTotal;
    final form = supp.document.form.copyWith(total: total);
    final document = Document.sales(form, temporarySales);
    supp = supp.copyWith(document: document);
    emit(SalesDocumentsPageState.content(supp));
  }

  ///updates the chosen product on the sales page
  _handleProductUpdates() {
    if (_page != Pages.sales_page) return;
    final product = productsService.getCurrent;
    final supp = state.supplements.copyWith(
      product: product,
      quantity: '1',
      unitPrice: product.unitPrice.toString(),
    );
    emit(SalesDocumentsPageState.content(supp));
  }

  void _initSalesDocumentsPage(Pages page) {
    if (page != Pages.sales_documents_page) return;
    var supp = state.supplements;
    final documents = salesService.getList;
    documents.sort((b, a) => a.form.dateTime.compareTo(b.form.dateTime));
    supp = supp.copyWith(documents: documents);
    emit(SalesDocumentsPageState.content(supp));
  }

  void _initDocumentSalesPage(Pages page, [Document? document]) {
    if (page != Pages.document_sales_page) return;

    var supp = state.supplements;
    if (document == null) {
      //is adding new document
      supp = supp.copyWith(action: PageActions.adding);
    } else {
      //is viewing / editing existing document
      final form = document.form;
      supp = supp.copyWith(
          document: document, date: form.dateTime, action: PageActions.viewing);
    }
    salesService.initDocument(supp.document);
    emit(SalesDocumentsPageState.content(supp));
  }

  void _initSalesPage(Pages page, [Sales? sales, PageActions? action]) {
    if (page != Pages.sales_page) return;
    var supp = state.supplements;

    // action can't be null on the sales edit page.
    supp = supp.copyWith(action: action!);

    if (sales != null) {
      // is viewing / editing existing sales record
      final product = productsService.getById(sales.productId)!;
      supp = supp.copyWith(
          salesId: sales.id,
          quantity: sales.quantity.toString(),
          unitPrice: sales.unitPrice.toString(),
          product: product);
    }
    emit(SalesDocumentsPageState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await salesService.init();
      await productsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(SalesDocumentsPageState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void updateAmount(String unitPrice) =>
      _updateAttributes(unitPrice: unitPrice);

  void updateNotes(String description) =>
      _updateAttributes(description: description);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes(isDateAsTitle: isDateAsTitle);

  void updateDocument(Document? document) =>
      _updateAttributes(document: document);

  void _handleError(ApiErrors error) {
    emit(SalesDocumentsPageState.failed(state.supplements,
        message: error.message));
  }
}
