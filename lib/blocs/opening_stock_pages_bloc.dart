import '../source.dart';

class OpeningStockPagesBloc extends Cubit<OpeningStockPagesState> {
  OpeningStockPagesBloc(this.openingStockItemsService, this.productsService)
      : super(OpeningStockPagesState.initial()) {
    productsService.addListener(_handleProductUpdates);
    openingStockItemsService.addListener(_handleOpeningStockItemsUpdates);
  }

  OpeningStockPagesBloc.empty()
      : openingStockItemsService = OpeningStockItemsService(),
        productsService = ProductsService(),
        super(OpeningStockPagesState.initial());

  final OpeningStockItemsService openingStockItemsService;
  final ProductsService productsService;

  Product? getProductById(String id) => productsService.getById(id);

  void init(Pages page,
      [OpeningStockItem? openingStockItem, PageActions? action]) async {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initOpeningStockItemsPage(page);
    _initOpeningStockItemPage(page, action, openingStockItem);
  }

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateUnitValue(String value) => _updateAttributes(unitValue: value);

  void updateDescription(String description) =>
      _updateAttributes(description: description);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void save() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OpeningStockPagesState.loading(supp));
    try {
      await openingStockItemsService.add(supp.getOpeningStockItem);
      emit(OpeningStockPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void edit() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OpeningStockPagesState.loading(supp));
    try {
      await openingStockItemsService.edit(supp.getOpeningStockItem);
      emit(OpeningStockPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void delete() async {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));

    try {
      await openingStockItemsService.delete(supp.openingStockItemId);
      emit(OpeningStockPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  void _updateAttributes(
      {String? description,
      String? quantity,
      PageActions? action,
      String? unitValue}) {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));

    supp = supp.copyWith(
      action: action ?? supp.action,
      unitValue: unitValue?.trim() ?? supp.unitValue,
      quantity: quantity?.trim() ?? supp.quantity,
      description: description ?? supp.description,
    );
    emit(OpeningStockPagesState.content(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(OpeningStockPagesState.loading(supp));
    errors['product'] =
        InputValidation.validateText(supp.product.id, 'Product');
    errors['unitValue'] =
        InputValidation.validateNumber(supp.unitValue, 'Unit Value');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(OpeningStockPagesState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));
    final product = productsService.getCurrent;
    supp = supp.copyWith(product: product);
    emit(OpeningStockPagesState.content(supp));
  }

  _handleOpeningStockItemsUpdates() {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));
    final items = openingStockItemsService.getList;
    supp = supp.copyWith(openingStockItems: items);
    emit(OpeningStockPagesState.content(supp));
  }

  _initOpeningStockItemsPage(Pages page) {
    if (page != Pages.opening_stock_items_page) return;

    var supp = state.supplements;
    final openingStockItems = openingStockItemsService.getList;
    supp = supp.copyWith(openingStockItems: openingStockItems);
    emit(OpeningStockPagesState.content(supp));
  }

  _initOpeningStockItemPage(Pages page,
      [PageActions? action, OpeningStockItem? openingStockItem]) {
    if (page != Pages.opening_stock_item_page) return;

    var supp = state.supplements;
    supp = supp.copyWith(action: action!);

    if (openingStockItem != null) {
      final product = productsService.getById(openingStockItem.productId);
      supp = supp.copyWith(
          product: product!,
          openingStockItemId: openingStockItem.id,
          description: supp.description,
          quantity: openingStockItem.quantity.toString(),
          unitValue: openingStockItem.unitValue.toString());
    }
    emit(OpeningStockPagesState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await productsService.init();
      await openingStockItemsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(OpeningStockPagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void _handleError(ApiErrors error) {
    emit(OpeningStockPagesState.failed(state.supplements,
        message: error.message));
  }
}
