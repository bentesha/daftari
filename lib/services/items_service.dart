import 'dart:async';
import 'service.dart';
import '../source.dart';

class ItemsService extends Service<Item> {
  static final box = Hive.box(Constants.kItemsBox);
  ItemsService() : super(box);

  static var _selectedId = '';

  List<Item> get getItemList => super.getList;
  String get getSelectedItemId => _selectedId;
  
  Item? getItemById(String id) => box.get(id) as Item?;

  List<Item> init() => super.getAll();

  Future<void> addItem(Item item) async => super.add(item);

  Future<void> editItem(Item item) async => super.edit(item);

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
