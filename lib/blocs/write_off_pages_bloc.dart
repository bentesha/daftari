import '../source.dart';

class WriteOffPagesBloc extends Cubit<WriteOffPagesState> {
  WriteOffPagesBloc(
      this.writeOffsService, this.productsService, this.writeOffsTypesService)
      : super(WriteOffPagesState.initial()) {
    writeOffsService.addListener(_handleDocumentUpdates);
    productsService.addListener(_handleProductUpdates);
    writeOffsTypesService.addListener(_handleWriteOffTypesUpdates);
  }

  WriteOffPagesBloc.empty()
      : writeOffsService = WriteOffsService(),
        productsService = ProductsService(),
        writeOffsTypesService = WriteOffsTypesService(),
        super(WriteOffPagesState.initial());

  final WriteOffsService writeOffsService;
  final ProductsService productsService;
  final WriteOffsTypesService writeOffsTypesService;
  var _page = Pages.purchases_page;

  Product getProductById(String id) => productsService.getById(id)!;

  bool get documentHasUnsavedChanges => writeOffsService.hasChanges;

  void init(Pages page,
      {Document? document, WriteOff? writeOff, PageActions? action}) async {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    _page = page;

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initWriteOffsDocumentsPage(page);
    _initDocumentWriteOffsPage(page, document);
    _initWriteOffsPage(page, writeOff, action);
  }

  void updateNotes(String description) =>
      _updateAttributes(description: description);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateTitle(String title) => _updateAttributes(title: title);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void updateType(WriteOffTypes type) => _updateAttributes(type: type);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes(isDateAsTitle: isDateAsTitle);

  void saveDocument() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(WriteOffPagesState.loading(supp));

    var document = supp.document;
    var form = document.form;
    final now = DateTime.now();

    form = document.form.copyWith(
        date: now.millisecondsSinceEpoch.toString(),
        title:
            supp.isDateAsTitle ? DateFormatter.convertToDMY(now) : form.title);
    final writeOffList = writeOffsService.getTemporaryList;
    document = Document.writeOffs(form, supp.type, writeOffList);

    try {
      await writeOffsService.addDocument(document);
      emit(WriteOffPagesState.success(supp));
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
      await writeOffsService.editDocument(document);
      emit(WriteOffPagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void deleteDocument() async {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    try {
      await writeOffsService.deleteDocument(supp.document.form.id);
      emit(WriteOffPagesState.success(supp));
    } catch (e) {
      _handleError(e);
    }
  }

  void addWriteOff() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final writeOff = WriteOff.toServer(
        id: Utils.getRandomId(),
        productId: supp.product.id,
        quantity: supp.parsedQuantity);

    writeOffsService.addItemTemporarily(writeOff);
    emit(WriteOffPagesState.success(supp));
  }

  void editWriteOff() {
    _validateSalesDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final writeOff = WriteOff.toServer(
        id: supp.writeOffId,
        productId: supp.product.id,
        quantity: supp.parsedQuantity);

    writeOffsService.editTemporaryItem(writeOff);
    emit(WriteOffPagesState.success(supp));
  }

  void deleteWriteOff() {
    var supp = state.supplements;
    writeOffsService.deleteTemporaryItem(supp.writeOffId);
    emit(WriteOffPagesState.success(supp));
  }

  void _updateAttributes(
      {String? title,
      DateTime? date,
      bool? isDateAsTitle,
      String? quantity,
      WriteOffTypes? type,
      PageActions? action,
      String? description}) {
    var supp = state.supplements;

    emit(WriteOffPagesState.loading(supp));
    var form = supp.document.form;
    form = form.copyWith(
        title: title ?? form.title,
        description: description ?? form.description);
    supp = supp.copyWith(
        document: supp.document.copyWith(form: form),
        quantity: quantity ?? supp.quantity,
        date: date ?? supp.date,
        action: action ?? supp.action,
        type: type ?? supp.type,
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(WriteOffPagesState.content(supp));
  }

  void clearChanges() {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    writeOffsService.clearTemporaryList();
    emit(WriteOffPagesState.success(supp));
  }

  _validateSalesDetails() => _validate(false);

  _validate([bool isValidatingDocumentDetails = true]) {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));

    final form = supp.document.form;
    final errors = <String, String?>{};
    if (isValidatingDocumentDetails && (!supp.isDateAsTitle)) {
      errors['title'] = InputValidation.validateText(form.title, 'Title');
    }
    //validating purchases details
    if (!isValidatingDocumentDetails) {
      errors['product'] =
          InputValidation.validateText(supp.product.id, 'Product');
      errors['quantity'] =
          InputValidation.validateNumber(supp.quantity, 'Quantity');
    }
    supp = supp.copyWith(errors: errors);
    emit(WriteOffPagesState.content(supp));
  }

  _handleDocumentUpdates() {
    emit(WriteOffPagesState.loading(state.supplements));
    _updateWriteOffsDocumentsPage();
    _updateDocumentWriteOffsPage();
  }

  _updateWriteOffsDocumentsPage() {
    if (_page != Pages.write_offs_documents_page) return;
    final supp =
        state.supplements.copyWith(documents: writeOffsService.getList);
    emit(WriteOffPagesState.content(supp));
  }

  _updateDocumentWriteOffsPage() {
    if (_page != Pages.document_write_offs_page) return;
    var supp = state.supplements;
    final temporaryWriteOffs = writeOffsService.getTemporaryList;
    final document =
        Document.writeOffs(supp.document.form, supp.type, temporaryWriteOffs);
    supp = supp.copyWith(document: document);
    emit(WriteOffPagesState.content(supp));
  }

  ///updates the chosen product on the writeOff page
  _handleProductUpdates() {
    if (_page != Pages.write_off_page) return;
    final product = productsService.getCurrent;
    final supp = state.supplements.copyWith(product: product, quantity: '1');
    emit(WriteOffPagesState.content(supp));
  }

  _handleWriteOffTypesUpdates() {
    if (_page != Pages.write_off_page) return;
    final type = writeOffsTypesService.getSelectedType;
    final supp = state.supplements.copyWith(type: type);
    emit(WriteOffPagesState.content(supp));
  }

  void _initWriteOffsDocumentsPage(Pages page) {
    if (page != Pages.write_offs_documents_page) return;

    var supp = state.supplements;
    final documents = writeOffsService.getList;
    supp = supp.copyWith(documents: documents);
    emit(WriteOffPagesState.content(supp));
  }

  void _initDocumentWriteOffsPage(Pages page, [Document? document]) {
    if (page != Pages.document_write_offs_page) return;

    var supp = state.supplements;
    if (document == null) {
      //is adding new document
      supp = supp.copyWith(action: PageActions.adding);
    } else {
      //is viewing / editing existing document
      final form = document.form;
      final isDateAsTitle =
          _checkIfDateIsUsedAsTitle(form.title, form.dateTime);
      final type = document.maybeWhen(
          writeOffs: (_, type, __) => type, orElse: () => null);

      supp = supp.copyWith(
          document: document,
          date: form.dateTime,
          type: type!,
          isDateAsTitle: isDateAsTitle,
          action: PageActions.viewing);
    }
    writeOffsService.initDocument(supp.document);
    emit(WriteOffPagesState.content(supp));
  }

  bool _checkIfDateIsUsedAsTitle(String title, DateTime date) {
    final dateFromTitle = DateFormatter.convertToDMY(date);
    return title == dateFromTitle;
  }

  void _initWriteOffsPage(Pages page,
      [WriteOff? writeOff, PageActions? action]) {
    if (page != Pages.write_off_page) return;
    var supp = state.supplements;

    //action can't be null on the write-off page.
    supp = supp.copyWith(action: action!);

    if (writeOff != null) {
      //is viewing / editing existing sales record
      final product = productsService.getById(writeOff.productId)!;
      supp = supp.copyWith(
          writeOffId: writeOff.id,
          quantity: writeOff.quantity.toString(),
          product: product);
    }
    emit(WriteOffPagesState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await writeOffsService.init();
      await productsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(WriteOffPagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void _handleError(var error) {
    final message = getErrorMessage(error);
    emit(WriteOffPagesState.failed(state.supplements, message: message));
  }
}
