import '../source.dart';

class RecordsPageBloc extends Cubit<RecordsPageState> with ServicesInitializer {
  RecordsPageBloc(this.recordsService, this.productsService)
      : super(RecordsPageState.initial()) {
    recordsService.addListener(() => _handleRecordsUpdates());
    productsService.addListener(() => _handleProductUpdates());
  }

  final RecordsService recordsService;
  final ProductsService productsService;

  bool get hasProducts => productsService.getProductList.isNotEmpty;

  Product? get getSelectedProduct =>
      productsService.getProductById(state.supplements.productId);

  Record? _record;

  void init([String? groupId, Record? record]) {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    initServices(
        productsService: productsService, recordsService: recordsService);
    final recordList = recordsService.getList;
    final productList = productsService.getProductList;
    supp = supp.copyWith(
        productList: productList,
        recordList: recordList,
        groupId: groupId ?? supp.groupId);
    if (record != null) {
      _record = record;
      supp = supp.copyWith(
          sellingPrice: record.sellingPrice.toString(),
          quantity: record.quantity.toString(),
          date: record.date,
          notes: record.notes,
          productId: record.product.id);
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

    final index = supp.productList.indexWhere((e) => e.id == supp.productId);

    final record = Record(
      date: supp.date,
      id: Utils.getRandomId(),
      groupId: supp.groupId,
      quantity: double.parse(supp.quantity),
      product: supp.productList[index],
      sellingPrice: double.parse(supp.sellingPrice),
      notes: supp.notes,
    );
    await recordsService.add(record);
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
    await recordsService.edit(record);
    emit(RecordsPageState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));

    final errors = <String, String?>{};

    errors['product'] = InputValidation.validateText(supp.productId, 'product');
    errors['price'] =
        InputValidation.validateNumber(supp.sellingPrice, 'price');
    errors['quantity'] =
        InputValidation.validateNumber(supp.quantity, 'Quantity');

    supp = supp.copyWith(errors: errors);
    emit(RecordsPageState.content(supp));
  }

  _handleRecordsUpdates() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    supp = supp.copyWith(recordList: recordsService.getList);
    emit(RecordsPageState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(RecordsPageState.loading(supp));
    final id = productsService.getSelectedProductId;
    final product = productsService.getProductById(id);
    final products = productsService.getProductList;
    supp = supp.copyWith(
        productId: id,
        quantity: '1',
        sellingPrice: product!.unitPrice.toString(),
        productList: products);
    emit(RecordsPageState.content(supp));
  }
}
