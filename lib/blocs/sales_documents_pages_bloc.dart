import '../source.dart';

class SalesDocumentsPagesBloc extends Cubit<SalesDocumentsPagesState>
    with ServicesInitializer {
  SalesDocumentsPagesBloc(this.salesService, this.productsService)
      : super(SalesDocumentsPagesState.initial()) {
    salesService.addListener(() => _handleDocumentUpdates());
    productsService.addListener(() => _handleProductListUpdates());
  }

  final SalesService salesService;
  final ProductsService productsService;

  Product getProductById(String id) => productsService.getById(id)!;

  void init(Pages page,
      {Document? document, Sales? sales, PageActions? action}) async {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    await initServices(
        productsService: productsService, salesService: salesService);

    _initSalesDocumentsPage(page);
    _initDocumentSalesPage(page, document);
    _initSalesEditPage(page, sales, action);
  }

  void updateAmount(String unitPrice) =>
      _updateAttributes(unitPrice: unitPrice);

  void updateNotes(String description) =>
      _updateAttributes(description: description);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateTitle(String title) => _updateAttributes(title: title);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes(isDateAsTitle: isDateAsTitle);

  void saveDocument() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(SalesDocumentsPagesState.loading(supp));

    var document = supp.document;
    var form = document.form;
    final now = DateTime.now();

    form = document.form.copyWith(
        date: now.millisecondsSinceEpoch.toString(),
        title:
            supp.isDateAsTitle ? DateFormatter.convertToDMY(now) : form.title);
    final salesList = salesService.getSalesList;
    document = Document.sales(form, salesList);
    await salesService.add(document);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void editDocument() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    var document = supp.document;
    if (supp.isDateAsTitle) {
      final form =
          document.form.copyWith(title: DateFormatter.convertToDMY(supp.date));
      document = document.copyWith(form: form);
    }

    await salesService.edit(document);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    await salesService.delete(supp.document.form.id);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void addSales() async {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final sales = Sales.toServer(
        id: Utils.getRandomId(),
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    salesService.addSalesTemporarily(sales);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void editSales() async {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final sales = Sales.toServer(
        id: supp.salesId,
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    salesService.editTemporarySales(sales);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void deleteSales() async {
    var supp = state.supplements;
    salesService.deleteTemporarySales(supp.salesId);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void _updateAttributes(
      {String? title,
      DateTime? date,
      bool? isDateAsTitle,
      String? quantity,
      String? unitPrice,
      PageActions? action,
      String? description}) {
    var supp = state.supplements;

    emit(SalesDocumentsPagesState.loading(supp));
    var form = supp.document.form;
    form = form.copyWith(
        title: title ?? form.title,
        description: description ?? form.description);
    supp = supp.copyWith(
        document: supp.document.copyWith(form: form),
        quantity: quantity ?? supp.quantity,
        unitPrice: unitPrice ?? supp.unitPrice,
        date: date ?? supp.date,
        action: action ?? supp.action,
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(SalesDocumentsPagesState.content(supp));
  }

  _validateSalesDetails() => _validate(false);

  _validate([bool isValidatingDocumentDetails = true]) {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));

    final form = supp.document.form;
    final errors = <String, String?>{};
    if (isValidatingDocumentDetails && (!supp.isDateAsTitle)) {
      errors['title'] = InputValidation.validateText(form.title, 'Title');
    }
    //validating sales details
    if (!isValidatingDocumentDetails) {
      errors['product'] =
          InputValidation.validateText(supp.product.id, 'Product');
      errors['price'] = InputValidation.validateNumber(supp.unitPrice, 'Price');
      errors['quantity'] =
          InputValidation.validateNumber(supp.quantity, 'Quantity');
    }
    supp = supp.copyWith(errors: errors);
    emit(SalesDocumentsPagesState.content(supp));
  }

  ///updates the documents on the sales documents page
  _handleDocumentUpdates() {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    final documents = salesService.getList;
    final temporarySales = salesService.getSalesList;
    final document = Document.sales(supp.document.form, temporarySales);
    supp = supp.copyWith(documents: documents, document: document);
    emit(SalesDocumentsPagesState.content(supp));
  }

  ///updates the chosen product on the sales edit page
  _handleProductListUpdates() {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    final product = productsService.getCurrent;
    supp = supp.copyWith(
        product: product,
        quantity: '1',
        unitPrice: product.unitPrice.toString());
    emit(SalesDocumentsPagesState.content(supp));
  }

  void _initSalesDocumentsPage(Pages page) {
    if (page != Pages.sales_documents_page) return;

    var supp = state.supplements;
    final documents = salesService.getList;
    supp = supp.copyWith(documents: documents);
    emit(SalesDocumentsPagesState.content(supp));
  }

  void _initDocumentSalesPage(Pages page, [Document? document]) {
    if (page != Pages.document_sales_page) return;

    var supp = state.supplements;
    if (document == null) {
      //is adding new document
      supp = supp.copyWith(action: PageActions.adding);
    } else {
      //is viewing / editing existing document
      salesService.initDocument(document);
      final form = document.form;
      final isDateAsTitle =
          _checkIfDateIsUsedAsTitle(form.title, form.dateTime);
      supp = supp.copyWith(
          document: document,
          date: form.dateTime,
          isDateAsTitle: isDateAsTitle,
          action: PageActions.viewing);
    }
    emit(SalesDocumentsPagesState.content(supp));
  }

  bool _checkIfDateIsUsedAsTitle(String title, DateTime date) {
    final dateFromTitle = DateFormatter.convertToDMY(date);
    return title == dateFromTitle;
  }

  ///action can't be null on the sales edit page.
  void _initSalesEditPage(Pages page, [Sales? sales, PageActions? action]) {
    if (page != Pages.sales_page) return;

    var supp = state.supplements;

    supp = supp.copyWith(action: action!);

    if (sales != null) {
      //is viewing / editing existing sales record
      final product = productsService.getById(sales.productId)!;
      supp = supp.copyWith(
          salesId: sales.id,
          quantity: sales.quantity.toString(),
          unitPrice: sales.unitPrice.toString(),
          product: product);
    }
    emit(SalesDocumentsPagesState.content(supp));
  }

  static const titleErrorMessage =
      'ONLY TWO RECORDING FORMATS ARE ALLOWED IN A DAY:\n\n1. Creating multiple custom-titled groups\n\n2. Using a respective day as a group for all sales records in that day';
}
