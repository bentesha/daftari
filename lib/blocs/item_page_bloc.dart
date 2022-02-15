import '../source.dart';

class ItemPageBloc extends Cubit<ItemPageState> {
  ItemPageBloc(this.service) : super(ItemPageState.initial()) {
    service.addListener(() => _handleItemUpdates());
  }

  final ItemsService service;

  ///Item should be specified when it is to be edited.
  ///Category is passed when item is created for the first time.
  ///Also category is needed on category page that displays all items of the same ID
  void init({Item? item, String? categoryId}) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    var itemList = service.getAll();

    log(itemList.toString());
    log(itemList.first.categoryId);

    if (categoryId != null) {
      log(categoryId);

      itemList = itemList.where((e) => e.categoryId == categoryId).toList();
      supp = supp.copyWith(categoryId: categoryId);
    }

    supp = supp.copyWith(itemList: itemList);

    if (item != null) {
      supp = supp.copyWith(
        unit: item.unit,
        unitPrice: item.unitPrice.toString(),
        title: item.title,
        quantity: item.quantity.toString(),
        categoryId: item.categoryId,
        id: item.id,
        barcode: item.barcode,
      );
    }
    emit(ItemPageState.content(supp));
  }

  void updateAttributes(
      {String? title,
      String? categoryId,
      String? unit,
      String? barcode,
      String? unitPrice,
      String? quantity}) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));

    supp = supp.copyWith(
        title: title?.trim() ?? supp.title,
        unit: unit?.trim() ?? supp.unit,
        categoryId: categoryId ?? supp.categoryId,
        unitPrice: unitPrice?.trim() ?? supp.unitPrice,
        quantity: quantity?.trim() ?? supp.quantity,
        barcode: barcode?.trim() ?? supp.barcode);
    emit(ItemPageState.content(supp));
  }

  void saveItem() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final item = Item(
        id: Utils.getRandomId(),
        categoryId: supp.categoryId,
        unit: supp.unit,
        title: supp.title,
        barcode: supp.barcode,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.addItem(item);
    emit(ItemPageState.success(supp));
  }

  void editItem() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final item = Item(
        id: supp.id,
        categoryId: supp.categoryId,
        unit: supp.unit,
        title: supp.title,
        barcode: supp.barcode,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.editItem(item);
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

  _handleItemUpdates() {
    log('updating items');
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    final items = service.getItemList;
    supp = supp.copyWith(itemList: items);
    emit(ItemPageState.content(supp));
  }
}
