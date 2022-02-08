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
    var supp = state.supp;
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

    var supp = state.supp;
    if (supp.errors.isNotEmpty) return;
    final item = Item(
        id: Utils.getRandomId(),
        unit: supp.unit,
        title: supp.title,
        unitPrice: double.parse(supp.unitPrice),
        quantity: double.parse(supp.quantity));
    await service.saveItem(item);
    emit(ItemPageState.success(supp));
  }

  _validate() {
    var supp = state.supp;
    final errors = <String, String>{};

    emit(ItemPageState.loading(supp));
    if (supp.title.isEmpty) {
      errors['title'] = 'Title cannot be empty';
    }
    if (supp.unit.isEmpty) {
      errors['unit'] = 'Unit cannot be empty';
    }
    if (supp.unitPrice.isEmpty) {
      errors['unitPrice'] = 'Unit price cannot be empty';
    } else if (double.tryParse(supp.unitPrice) == null) {
      errors['unitPrice'] = 'Invalid unit price!';
    }
    if (supp.quantity.isEmpty) {
      errors['quantity'] = 'Quantity cannot be empty';
    } else if (double.tryParse(supp.quantity) == null) {
      errors['quantity'] = 'Invalid quantity!';
    }

    supp = supp.copyWith(errors: errors);
    emit(ItemPageState.content(supp));
  }
}
