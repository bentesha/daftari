import '../source.dart';

class OpeningStockPagesBloc extends Cubit<OpeningStockPagesState>
    with ServicesInitializer {
  OpeningStockPagesBloc(this.openingStockItemsService, this.productsService)
      : super(OpeningStockPagesState.initial()) {
    productsService.addListener(() => _handleProductUpdates());
    openingStockItemsService.addListener(() => _handleItemsUpdates());
  }

  final OpeningStockItemsService openingStockItemsService;
  final ProductsService productsService;

  void init([OpeningStockItem? openingStockItem]) {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));
    initServices(
        openingStockItemsService: openingStockItemsService,
        productsService: productsService);

    if (openingStockItem != null) {
      supp = supp.copyWith(
          openingStockItem: openingStockItem,
          quantity: openingStockItem.quantity.toString(),
          unitValue: openingStockItem.unitValue.toString(),
          unitPrice: openingStockItem.product.unitPrice.toString());
    }

    final items = openingStockItemsService.getList;
    supp = supp.copyWith(openingStockItems: items);
    emit(OpeningStockPagesState.content(supp));
  }

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateUnitValue(String value) => _updateAttributes(unitValue: value);

  void updateUnitPrice(String price) => _updateAttributes(unitPrice: price);

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void saveItem() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OpeningStockPagesState.loading(supp));


    final item = OpeningStockItem(
        id: Utils.getRandomId(),
        date: supp.openingStockItem.date,
        product: supp.openingStockItem.product
            .copyWith(unitPrice: double.parse(supp.unitPrice)),
        unitValue: double.parse(supp.unitValue),
        quantity: double.parse(supp.quantity));
    await openingStockItemsService.add(item);
    emit(OpeningStockPagesState.success(supp));
  }

  void editItem() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(OpeningStockPagesState.loading(supp));


    final item = OpeningStockItem(
        id: supp.openingStockItem.id,
        date: supp.openingStockItem.date,
        product: supp.openingStockItem.product
            .copyWith(unitPrice: double.parse(supp.unitPrice)),
        unitValue: double.parse(supp.unitValue),
        quantity: double.parse(supp.quantity));
    await openingStockItemsService.edit(item);
    emit(OpeningStockPagesState.success(supp));
  }

  void _updateAttributes(
      {String? unitPrice,
      String? quantity,
      DateTime? date,
      String? unitValue}) {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));

    supp = supp.copyWith(
      unitPrice: unitPrice?.trim() ?? supp.unitPrice,
      unitValue: unitValue?.trim() ?? supp.unitValue,
      quantity: quantity?.trim() ?? supp.quantity,
      openingStockItem: supp.openingStockItem.copyWith(date: date),
    );
    emit(OpeningStockPagesState.content(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(OpeningStockPagesState.loading(supp));
    errors['product'] = InputValidation.validateText(
        supp.openingStockItem.product.id, 'Product');
    errors['unitValue'] =
        InputValidation.validateNumber(supp.unitPrice, 'Unit Value');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(OpeningStockPagesState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));
    final product = productsService.getCurrent;
    supp = supp.copyWith(
        openingStockItem: supp.openingStockItem.copyWith(product: product));
    emit(OpeningStockPagesState.content(supp));
  }

  _handleItemsUpdates() {
    var supp = state.supplements;
    emit(OpeningStockPagesState.loading(supp));
    final items = openingStockItemsService.getList;
    supp = supp.copyWith(openingStockItems: items);
    emit(OpeningStockPagesState.content(supp));
  }
}
