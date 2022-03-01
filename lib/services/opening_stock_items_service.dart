import 'dart:async';
import '../source.dart';
import 'service.dart';

class OpeningStockItemsService extends Service<OpeningStockItem> {
  static final _box = Hive.box(Constants.kOpeningStockItemsBox);
  OpeningStockItemsService() : super(_box);

  var _totalAmount = 0.0;
  double get getTotalValue => _totalAmount;
  OpeningStockItem? getByProductId(String id) {
    final items = super.getList.where((e) => e.product.id == id).toList();
    if (items.isNotEmpty) return items.first;
    return null;
  }

  void init() {
    super.getAll();
    _getItemsTotalAmount();
  }

  @override
  Future<void> add(var item) async {
    await _box.put(item.id, item);

    _totalAmount += item.totalValue;
    super.refresh();
    notifyListeners();
  }

  @override
  Future<void> edit(var item) async {
    await _box.put(item.id, item);

    final index = super.getList.indexWhere((e) => e.id == item.id);
    final beforeEditRecordAmount = super.getList[index].totalValue;

    _totalAmount = _totalAmount - beforeEditRecordAmount + item.value;

    super.refresh();
    notifyListeners();
  }

  double _getItemsTotalAmount() {
    double _totalAmount = 0.0;
    for (OpeningStockItem item in super.getList) {
      _totalAmount += item.totalValue;
    }
    return _totalAmount;
  }
}
