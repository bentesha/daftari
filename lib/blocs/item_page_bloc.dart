import '../source.dart';

class ItemPageBloc extends Cubit<ItemPageState> {
  ItemPageBloc(this.service) : super(ItemPageState.initial());

  final ItemsService service;

  void updateTitle(String title) => _updateItem(title: title);

  void updateUnit(String unit) => _updateItem(unit: unit);

  void updateQuantity(String quantity) => _updateItem(quantity: quantity);

  void updateUnitPrice(String unitPrice) => _updateItem(unitPrice: unitPrice);

  void _updateItem(
      {String? title, String? unit, String? unitPrice, String? quantity}) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));

    supp = supp.copyWith(
      title: title?.trim() ?? supp.title,
      unit: unit?.trim() ?? supp.unit,
      unitPrice: unitPrice?.trim() ?? supp.unitPrice,
      quantity: quantity?.trim() ?? supp.quantity,
    );
    emit(ItemPageState.content(supp));
  }

  void saveItem() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final item = Item(
        id: Utils.getRandomId(),
        unit: supp.unit,
        title: supp.title,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.saveItem(item);
    emit(ItemPageState.success(supp));
  }

  void updateSearchQuery(String query) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    final list = service.getItemList
        .where((e) => e.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    supp = supp.copyWith(itemList: list, query: query);
    emit(ItemPageState.content(supp));
  }

  void clearQuery() {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    final list = service.getItemList;
    supp = supp.copyWith(itemList: list, query: '');
    emit(ItemPageState.content(supp));
  }

  void updateId(String id) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    service.updateId(id);
    emit(ItemPageState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(ItemPageState.loading(supp));
    errors['title'] = InputValidation.validateText(supp.title, 'Title');
    errors['unit'] = InputValidation.validateText(supp.unit, 'Unit');

    errors['unitPrice'] =
        InputValidation.validateNumber(supp.unitPrice, 'Unit Price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(ItemPageState.content(supp));
  }
}
