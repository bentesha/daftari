import '../source.dart';

class PurchasesPagesBloc extends Cubit<PurchasesPagesState> {
  PurchasesPagesBloc(this.purchasesService, this.productsService)
      : super(PurchasesPagesState.initial()) {
    purchasesService.addListener(_handleDocumentUpdates);
    productsService.addListener(_handleProductUpdates);
  }

  PurchasesPagesBloc.empty()
      : purchasesService = PurchasesService(),
        productsService = ProductsService(),
        super(PurchasesPagesState.initial());

  final PurchasesService purchasesService;
  final ProductsService productsService;
  var _page = Pages.purchases_page;

  Product getProductById(String id) => productsService.getById(id)!;

  bool get documentHasUnsavedChanges => purchasesService.hasChanges;

  void init(Pages page,
      {Document? document, Purchase? purchase, PageActions? action}) async {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));
    _page = page;

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initPurchasesDocumentsPage(page);
    _initDocumentPurchasesPage(page, document);
    _initPurchasesPage(page, purchase, action);
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

    form = document.form.copyWith(date: now.millisecondsSinceEpoch.toString());
    final purchaseList = purchasesService.getTemporaryList;
    document = Document.purchases(form, purchaseList);

    try {
      await purchasesService.addDocument(document);
      emit(PurchasesPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void editDocument() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    var document = supp.document;
    try {
      await purchasesService.editDocument(document);
      emit(PurchasesPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(PurchasesPagesState.loading(supp));
    try {
      await purchasesService.deleteDocument(supp.document.form.id);
      emit(PurchasesPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void addPurchase() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final purchase = Purchase.toServer(
        id: Utils.getRandomId(),
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    purchasesService.addItemTemporarily(purchase);
    emit(PurchasesPagesState.success(supp));
  }

  void editPurchase() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final purchase = Purchase.toServer(
        id: supp.purchasesId,
        productId: supp.product.id,
        quantity: supp.parsedQuantity,
        unitPrice: supp.parsedUnitPrice);

    purchasesService.editTemporaryItem(purchase);
    emit(PurchasesPagesState.success(supp));
  }

  void deletePurchase() {
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
    form = form.copyWith(description: description ?? form.description);
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

    final errors = <String, String?>{};
    //validating purchases details
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
    final total = purchasesService.temporaryPurchasesTotal;
    final form = supp.document.form.copyWith(total: total);
    final document = Document.purchases(form, temporaryPurchases);
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

  void _initPurchasesDocumentsPage(Pages page) {
    if (page != Pages.purchases_documents_page) return;

    var supp = state.supplements;
    final documents = purchasesService.getList;
    documents.sort((b, a) => a.form.dateTime.compareTo(b.form.dateTime));
    supp = supp.copyWith(documents: documents);
    emit(PurchasesPagesState.content(supp));
  }

  void _initDocumentPurchasesPage(Pages page, [Document? document]) {
    if (page != Pages.document_purchases_page) return;

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
    purchasesService.initDocument(supp.document);
    emit(PurchasesPagesState.content(supp));
  }

  void _initPurchasesPage(Pages page,
      [Purchase? purchases, PageActions? action]) {
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

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await purchasesService.init();
      await productsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(PurchasesPagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void _handleError(ApiErrors error) {
    emit(PurchasesPagesState.failed(state.supplements, message: error.message));
  }
}
