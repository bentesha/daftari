import '../source.dart';

class SalesDocumentsPagesBloc extends Cubit<SalesDocumentsPagesState>
    with ServicesInitializer {
  SalesDocumentsPagesBloc(this.salesService, this.productsService)
      : super(SalesDocumentsPagesState.initial()) {
    salesService.addListener(() => _handleDocumentUpdates());
    productsService.addListener(() => _handleItemListUpdates());
  }

  final SalesService salesService;
  final ProductsService productsService;

  void init([Document? document]) {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    initServices(productsService: productsService, salesService: salesService);

    final documents = salesService.getList;
    supp = supp.copyWith(documents: documents);

    if (document != null) {
      //isEditing or viewing sales document
      supp = supp.copyWith(document: document);
    }
    emit(SalesDocumentsPagesState.content(supp));
  }

  void updateAmount(String unitPrice) =>
      _updateAttributes(unitPrice: unitPrice);

  void updateNotes(String description) =>
      _updateAttributes(description: description);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateTitle(String title) => _updateAttributes(title: title);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes(isDateAsTitle: isDateAsTitle);

  void _updateAttributes(
      {String? title,
      DateTime? date,
      bool? isDateAsTitle,
      String? quantity,
      String? unitPrice,
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
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(SalesDocumentsPagesState.content(supp));
  }

  void saveGroup() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    var form = supp.document.form;

    final title =
        supp.isDateAsTitle ? DateFormatter.convertToDOW(supp.date) : form.title;

    form = supp.document.form.copyWith(title: title);
    final sales =
        supp.document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    final document = Document.sales(form, sales);
    await salesService.add(document);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void editDocument() async {
    var supp = state.supplements;
    supp = supp.copyWith(errors: {});

    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    var form = supp.document.form;

    final isEditing = form.id.trim().isNotEmpty;
    final title = isEditing
        ? supp.isDateAsTitle
            ? DateFormatter.convertToDOW(supp.date)
            : supp.document.form.title
        : supp.document.form.title;

    form = supp.document.form.copyWith(title: title);
    final sales =
        supp.document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    final document = Document.sales(form, sales);
    await salesService.edit(document);
    emit(SalesDocumentsPagesState.success(supp));
  }

  void addSales() async {}

  void editSales() async {}

  _validate() {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));

    final form = supp.document.form;

    final errors = <String, String?>{};
    final isEditing = form.id.trim().isNotEmpty;
    if (!supp.isDateAsTitle || isEditing) {
      errors['title'] = InputValidation.validateText(form.title, 'Title');
    }
    supp = supp.copyWith(errors: errors);
    emit(SalesDocumentsPagesState.content(supp));
  }

  _handleDocumentUpdates() {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    final currentDocument = salesService.getCurrent;
    supp = supp.copyWith(document: currentDocument);
    emit(SalesDocumentsPagesState.content(supp));
  }

  _handleItemListUpdates() {
    var supp = state.supplements;
    emit(SalesDocumentsPagesState.loading(supp));
    productsService.getList;
    emit(SalesDocumentsPagesState.content(supp));
  }

  static const titleErrorMessage =
      'ONLY TWO RECORDING FORMATS ARE ALLOWED IN A DAY:\n\n1. Creating multiple custom-titled groups\n\n2. Using a respective day as a group for all sales records in that day';
}
