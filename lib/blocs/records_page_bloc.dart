import '../source.dart';

class RecordsPageBloc extends Cubit<RecordsPageState> {
  RecordsPageBloc(this.recordsService, this.itemsService)
      : super(RecordsPageState.initial()) {
    recordsService.addListener(() => _handleRecordsUpdates());
    itemsService.addListener(() => _handleSelectedItemId());
  }

  final RecordsService recordsService;
  final ItemsService itemsService;

  bool get hasItems => itemsService.getItemList.isNotEmpty;

  Item? get getSelectedItem =>
      itemsService.getItemById(state.supplements.itemId);

  Record? _record;

  void init([String? groupId, Record? record]) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final recordList = recordsService.getAll();
    final itemList = itemsService.getAll();
    supp = supp.copyWith(
        itemList: itemList,
        recordList: recordList,
        groupId: groupId ?? supp.groupId);
    if (record != null) {
      _record = record;
      supp = supp.copyWith(
          sellingPrice: record.sellingPrice.toString(),
          quantity: record.quantity.toString(),
          date: record.date,
          notes: record.notes,
          itemId: record.item.id);
    }
    emit(RecordsPageState.content(supp));
  }

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateAmount(String amount) => _updateAttributes(amount: amount);

  void updateNotes(String notes) => _updateAttributes(notes: notes);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  _updateAttributes(
      {DateTime? date, String? quantity, String? amount, String? notes}) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = supp.copyWith(
      date: date ?? supp.date,
      quantity: quantity ?? supp.quantity,
      sellingPrice: amount ?? supp.sellingPrice,
      notes: notes ?? supp.notes,
    );

    emit(RecordsPageState.content(supp));
  }

  void saveRecord() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final index = supp.itemList.indexWhere((e) => e.id == supp.itemId);

    final record = Record(
      date: supp.date,
      id: Utils.getRandomId(),
      groupId: supp.groupId,
      type: RecordsTypes.sales,
      quantity: double.parse(supp.quantity),
      item: supp.itemList[index],
      sellingPrice: double.parse(supp.sellingPrice),
      notes: supp.notes,
    );
    await recordsService.addRecord(record);
    emit(RecordsPageState.success(supp));
  }

  void editRecord() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final record = _record!.copyWith(
        quantity: double.parse(supp.quantity),
        sellingPrice: double.parse(supp.sellingPrice),
        notes: supp.notes);
    await recordsService.editRecord(record);
    emit(RecordsPageState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));

    final errors = <String, String?>{};

    errors['item'] = InputValidation.validateText(supp.itemId, 'Item');
    errors['price'] =
        InputValidation.validateNumber(supp.sellingPrice, 'Item Price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(RecordsPageState.content(supp));
  }

  _handleRecordsUpdates() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = supp.copyWith(recordList: recordsService.getRecordList);
    emit(RecordsPageState.content(supp));
  }

  _handleSelectedItemId() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final id = itemsService.getSelectedItemId;
    final item = itemsService.getItemById(id);
    supp = supp.copyWith(
        itemId: id, quantity: '1', sellingPrice: item!.unitPrice.toString());
    emit(RecordsPageState.content(supp));
  }
}
