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
    if (supp.itemId.isEmpty) return null;
    final index = supp.itemList.indexWhere((e) => e.id == supp.itemId);
    return supp.itemList[index].title;
  }

  Record? _record;
  int? _day;

  Map<int, double> get getRecordsTotalAmount =>
      recordsService.getAllTotalAmounts();

  double get getDayTotalAmount {
    return recordsService.getTotalAmountsByDay(_day!);
  }

  List<Record> get getSpecificDayRecords {
    return state.supplements.recordList
        .where((e) => e.date.day == _day)
        .toList();
  }

  List<int> get getDaysWithRecords => recordsService.getDaysWithRecords;

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
      sellingPrice: amount ?? supp.sellingPrice,
      notes: notes ?? supp.notes,
      itemId: id ?? supp.itemId,
    );
    if (id != null) {
      emit(RecordsPageState.success(supp, RecordPages.search_item_page));
    }
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
    emit(RecordsPageState.success(supp, RecordPages.record_page));
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
    emit(RecordsPageState.success(supp, RecordPages.record_page));
  }

  void addGroup() {}

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

  _handleRecordStream(Record record) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    //supp.recordList.add(record);
    supp = supp.copyWith(recordList: recordsService.getRecordList);
    emit(RecordsPageState.content(supp));
  }

  void initRecord({Record? record}) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = RecordsSupplements.empty()
        .copyWith(itemList: supp.itemList, recordList: supp.recordList);

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

  void initGroupRecords() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));

    supp = supp.copyWith(date: DateTime.now());
    emit(RecordsPageState.content(supp));
  }

  void initDayRecords(int day) => _day = day;
}
