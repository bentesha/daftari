import '../source.dart';

class PurchasesPagesBloc extends Cubit<PurchasesPagesState>
    with ServicesInitializer {
  PurchasesPagesBloc(this.purchasesService, this.productsService)
      : super(PurchasesPagesState.initial()) {
    purchasesService.addListener(_handleDocumentUpdates);
    productsService.addListener(_handleProductUpdates);
  }

  final PurchasesService purchasesService;
  final ProductsService productsService;
  late final Pages _page;

  Product getProductById(String id) => productsService.getById(id)!;

  bool get documentHasUnsavedChanges => purchasesService.hasChanges;

  void init(Pages page,
      {Document? document, Purchases? purchase, PageActions? action}) async {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));
    _page = page;

    await _initServices();
    _initSalesDocumentsPage(page);
    _initDocumentSalesPage(page, document);
    _initSalesPage(page, purchase, action);
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

    emit(PurchasesPagesState.loading(supp));

    var document = supp.document;
    var form = document.form;
    final now = DateTime.now();

    form = document.form.copyWith(
        date: now.millisecondsSinceEpoch.toString(),
        title:
            supp.isDateAsTitle ? DateFormatter.convertToDMY(now) : form.title);
    final purchaseList = purchasesService.getTemporaryList;
    document = Document.purchases(form, purchaseList);

    try {
      await purchasesService.addDocument(document);
      emit(PurchasesPagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
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

    try {
      await purchasesService.editDocument(document);
      emit(PurchasesPagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));
    try {
      await purchasesService.deleteDocument(supp.document.form.id);
      emit(PurchasesPagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void addPurchase() async {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final purchase = Purchases.toServer(
        id: Utils.getRandomId(),
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    purchasesService.addItemTemporarily(purchase);
    emit(PurchasesPagesState.success(supp));
  }

  void editPurchase() async {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final purchase = Purchases.toServer(
        id: supp.purchasesId,
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    purchasesService.editTemporaryItem(purchase);
    emit(PurchasesPagesState.success(supp));
  }

  void deletePurchase() async {
    var supp = state.supplements;
    purchasesService.deleteTemporaryItem(supp.purchasesId);
    emit(PurchasesPagesState.success(supp));
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

    emit(PurchasesPagesState.loading(supp));
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
    emit(PurchasesPagesState.content(supp));
  }

  void clearChanges() {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));
    purchasesService.clearTemporaryList();
    emit(PurchasesPagesState.success(supp));
  }

  _validateSalesDetails() => _validate(false);

  _validate([bool isValidatingDocumentDetails = true]) {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));

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
    emit(PurchasesPagesState.content(supp));
  }

  _handleDocumentUpdates() {
    emit(PurchasesPagesState.loading(state.supplements));
    _updatePurchasesDocumentsPage();
    _updateDocumentPurchasesPage();
  }

  _updatePurchasesDocumentsPage() {
    if (_page != Pages.purchases_documents_page) return;
    final supp =
        state.supplements.copyWith(documents: purchasesService.getList);
    emit(PurchasesPagesState.content(supp));
  }

  _updateDocumentPurchasesPage() {
    if (_page != Pages.document_purchases_page) return;
    var supp = state.supplements;
    final temporaryPurchases = purchasesService.getTemporaryList;
    final document = Document.purchases(supp.document.form, temporaryPurchases);
    supp = supp.copyWith(document: document);
    emit(PurchasesPagesState.content(supp));
  }

  ///updates the chosen product on the sales page
  _handleProductUpdates() {
    if (_page != Pages.purchases_page) return;
    final product = productsService.getCurrent;
    final supp = state.supplements.copyWith(
        product: product,
        quantity: '1',
        unitPrice: product.unitPrice.toString());
    emit(PurchasesPagesState.content(supp));
  }

  void _initSalesDocumentsPage(Pages page) {
    if (page != Pages.purchases_documents_page) return;

    var supp = state.supplements;
    final documents = purchasesService.getList;
    supp = supp.copyWith(documents: documents);
    emit(PurchasesPagesState.content(supp));
  }

  void _initDocumentSalesPage(Pages page, [Document? document]) {
    if (page != Pages.document_purchases_page) return;

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
    purchasesService.initDocument(supp.document);
    emit(PurchasesPagesState.content(supp));
  }

  bool _checkIfDateIsUsedAsTitle(String title, DateTime date) {
    final dateFromTitle = DateFormatter.convertToDMY(date);
    return title == dateFromTitle;
  }

  void _initSalesPage(Pages page, [Purchases? purchases, PageActions? action]) {
    if (page != Pages.purchases_page) return;
    var supp = state.supplements;

    //action can't be null on the sales edit page.
    supp = supp.copyWith(action: action!);

    if (purchases != null) {
      //is viewing / editing existing sales record
      final product = productsService.getById(purchases.productId)!;
      supp = supp.copyWith(
          purchasesId: purchases.id,
          quantity: purchases.quantity.toString(),
          unitPrice: purchases.unitPrice.toString(),
          product: product);
    }
    emit(PurchasesPagesState.content(supp));
  }

  Future<void> _initServices() async {
    try {
      await initServices(
          productsService: productsService, purchasesService: purchasesService);
    } on ApiErrors catch (e) {
      emit(PurchasesPagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
  }

  void _handleError(var error) {
    final message = getErrorMessage(error);
    emit(PurchasesPagesState.failed(state.supplements, message: message));
  }
}
