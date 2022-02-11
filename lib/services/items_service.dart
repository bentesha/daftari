import 'dart:async';

import '../source.dart';

class ItemsService extends ChangeNotifier {
  static final _box = Hive.box(Constants.kItemsBox);
  static final _itemList = <Item>[];
  static var _selectedId = '';

  List<Item> get getItemList => _itemList;
  String get getSelectedItemId => _selectedId;

  List<Item> getAll() {
    if (_box.isEmpty) return [];

    for (Item item in _box.values) {
      final index = _itemList.indexWhere((e) => e.id == item.id);
      if (index == -1) _itemList.add(item);
    }

    return _itemList;
  }

  List<Item> init() => getAll();

  Item? getItemById(String id) => _box.get(id) as Item?;

  Future<void> saveItem(Item item) async {
    await _box.put(item.id, item);
    _itemList.add(item);
    notifyListeners();
  }

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
