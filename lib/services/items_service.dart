import 'dart:async';

import '../source.dart';

class ItemsService {
  static final _box = Hive.box(Constants.kItemsBox);
  static final _itemList = <Item>[];

  final itemsController = StreamController<Item>.broadcast();
  Stream<Item> get getItemStream => itemsController.stream;

  List<Item> get getItemList => _itemList;

  List<Item> getAll() {
    if (_box.isEmpty) return [];

    for (Item item in _box.values) {
      final index = _itemList.indexWhere((e) => e.id == item.id);
      if (index == -1) _itemList.add(item);
    }

    return _itemList;
  }

  Future<void> saveItem(Item item) async {
    await _box.put(item.id, item);
    _itemList.add(item);
    itemsController.add(item);
  }
}
