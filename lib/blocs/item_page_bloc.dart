import '../source.dart';

class ItemPageBloc extends Cubit<ItemPageState> {
  ItemPageBloc(this.service, this.categoriesService)
      : super(ItemPageState.initial()) {
    service.addListener(() => _handleItemUpdates());
    categoriesService.addListener(() => _handleCategoryUpdates());
  }

  final ItemsService service;
  final CategoriesService categoriesService;

  Category? get getSelectedCategory {
    final id = state.supplements.categoryId;
    final category = categoriesService.getCategoryById(id);
    return category;
  }

  ///Item should be specified when it is to be edited.
  ///Category is passed when item is created for the first time.
  ///Also category is needed on category page that displays all items of the same ID
  void init({Item? item, String? categoryId}) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    var itemList = service.getAll();
    final categories = categoriesService.getAll();

    if (categoryId != null) {
      itemList = itemList.where((e) => e.categoryId == categoryId).toList();
      supp = supp.copyWith(categoryId: categoryId);
    }

    supp = supp.copyWith(itemList: itemList, categoryList: categories);

    if (item != null) {
      supp = supp.copyWith(
        unit: item.unit,
        unitPrice: item.unitPrice.toString(),
        name: item.name,
        quantity: item.quantity.toString(),
        categoryId: item.categoryId,
        id: item.id,
        barcode: item.barcode,
      );
    }
    emit(ItemPageState.content(supp));
  }

  void updateAttributes(
      {String? name,
      String? categoryId,
      String? unit,
      String? barcode,
      String? unitPrice,
      String? quantity}) {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));

    supp = supp.copyWith(
        name: name?.trim() ?? supp.name,
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
        name: supp.name,
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
        name: supp.name,
        barcode: supp.barcode,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.editItem(item);
    emit(ItemPageState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(ItemPageState.loading(supp));
    errors['name'] = InputValidation.validateText(supp.name, 'name');
    errors['unit'] = InputValidation.validateText(supp.unit, 'Unit');
    errors['category'] =
        InputValidation.validateText(supp.categoryId, 'Category');

    errors['unitPrice'] =
        InputValidation.validateNumber(supp.unitPrice, 'Unit Price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(ItemPageState.content(supp));
  }

  _handleItemUpdates() {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    final items = service.getItemList;
    supp = supp.copyWith(itemList: items);
    emit(ItemPageState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(ItemPageState.loading(supp));
    final id = categoriesService.getSelectedCategoryId;
    supp = supp.copyWith(categoryId: id);
    emit(ItemPageState.content(supp));
  }
}
