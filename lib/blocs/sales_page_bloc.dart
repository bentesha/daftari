import '../source.dart';

class SalesPageBloc extends Cubit<SalesPageState> {
  SalesPageBloc(this.recordsService, this.itemsService)
      : super(SalesPageState.initial()) {
    itemsService.getItemStream.listen((item) {
      _handleItemsStream(item);
    });
  }

  final RecordsService recordsService;
  final ItemsService itemsService;

  void init() {
    var supp = state.supplements;
    emit(SalesPageState.loading(supp));
    final recordList = recordsService.getAll();
    final itemList = itemsService.getAll();

    supp = supp.copyWith(itemList: itemList, recordList: recordList);
    emit(SalesPageState.content(supp));
  }

  _handleItemsStream(item) {
    var supp = state.supplements;
    emit(SalesPageState.loading(supp));
    supp.itemList.add(item);
    emit(SalesPageState.content(supp));
  }
}
