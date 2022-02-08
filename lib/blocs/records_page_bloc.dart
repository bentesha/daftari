import '../source.dart';

class RecordsPageBloc extends Cubit<RecordsPageState> {
  RecordsPageBloc(this.recordsService, this.itemsService)
      : super(RecordsPageState.initial()) {
    recordsService.getRecordStream.listen((record) {
      _handleRecordStream(record);
    });
  }

  final RecordsService recordsService;
  final ItemsService itemsService;

  bool get hasItems => itemsService.getItemList.isNotEmpty;
  String? get getSelectedItem {
    final supp = state.supplements;
    if (supp.selectedItemId.isEmpty) return null;
    final index = supp.itemList.indexWhere((e) => e.id == supp.selectedItemId);
    return supp.itemList[index].title;
  }

  void init() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final recordList = recordsService.getAll();
    final itemList = itemsService.getAll();
    supp = supp.copyWith(itemList: itemList, recordList: recordList);
    emit(RecordsPageState.content(supp));
  }

  void updateDate(DateTime date) => _updateAttributes(date: date);

  void updateAmount(String amount) => _updateAttributes(amount: amount);

  void updateNotes(String notes) => _updateAttributes(notes: notes);

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateId(String id) => _updateAttributes(id: id);

  _updateAttributes(
      {DateTime? date,
      String? quantity,
      String? amount,
      String? notes,
      String? id}) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = supp.copyWith(
      date: date ?? supp.date,
      quantity: quantity ?? supp.quantity,
      amount: amount ?? supp.amount,
      notes: notes ?? supp.notes,
      selectedItemId: id ?? supp.selectedItemId,
    );
    if (id != null)
      emit(RecordsPageState.success(supp, RecordPages.search_item_page));
    emit(RecordsPageState.content(supp));
  }

  void updateSearchQuery(String query) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final list = itemsService.getItemList
        .where((e) => e.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    supp = supp.copyWith(itemList: list, query: query);
    emit(RecordsPageState.content(supp));
  }

  void clearQuery() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final list = itemsService.getItemList;
    supp = supp.copyWith(itemList: list, query: '');
    emit(RecordsPageState.content(supp));
  }

  void saveRecord() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final index = supp.itemList.indexWhere((e) => e.id == supp.selectedItemId);

    final record = Record(
      date: supp.date,
      id: Utils.getRandomId(),
      type: RecordsTypes.sales,
      quantity: double.parse(supp.quantity),
      item: supp.itemList[index],
      sellingPrice: double.parse(supp.amount),
      notes: supp.notes,
    );
    await recordsService.addRecord(record);
    emit(RecordsPageState.success(supp, RecordPages.record_page));
  }

  _validate() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));

    final errors = <String, String?>{};

    errors['item'] = InputValidation.validateText(supp.selectedItemId, 'Item');
    errors['amount'] = InputValidation.validateNumber(supp.amount, 'Amount');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(RecordsPageState.content(supp));
  }

  _handleRecordStream(Record record) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = supp.copyWith(recordList: recordsService.getRecordList);
    emit(RecordsPageState.content(supp));
  }

  void initRecord() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = RecordsSupplements.empty()
        .copyWith(itemList: supp.itemList, recordList: supp.recordList);
    emit(RecordsPageState.content(supp));
  }
}
