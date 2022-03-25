import '../utils/error_handler_mixin.dart';
import '../source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

class WithNoDocumentBaseService<T> extends ChangeNotifier with ErrorHandler {
  WithNoDocumentBaseService() {
    _current = _getInitialValue();
  }

  var _list = [];
  late T _current;

  String get _path => T == Product ? 'product' : 'openingStock';
  String get _url => root + _path;
  List<T> get getList => _list.whereType<T>().toList();
  T get getCurrent => _current!;

  Future<void> getAll([bool isRefreshing = false]) async {
    if (_list.isNotEmpty) return;
    try {
      final results = await http.get(_url) as List;
      if (results.isEmpty) return;

      final itemList = results.map((item) => _getValueFromJson(item)).toList();
      _list.addAll(itemList);
    } catch (e) {
      throw getError(e);
    }
  }

  void updateAttributes(List<T> list, {String? currentId}) {
    _list = list;
    if (currentId != null) updateCurrent(currentId);
  }

  T? getById(String id) {
    final items = _list.where((e) => e.id == id).toList();
    if (items.isNotEmpty) return items.first;
    return null;
  }

  Future<void> add(var item) async {
    try {
      final body = await http.post(_url, json: item.toJson());
      _current = _getValueFromJson(body);
      _list.add(_current);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> edit(var item, [String? url]) async {
    try {
      final response =
          await http.put(url ?? _url, item.id, json: item.toJson());
      final index = _list.indexWhere((e) => e.id == item.id);
      final body = json.decode(response.body);
      _list[index] = _getValueFromJson(body, url);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  Future<void> delete(String id, [String? url]) async {
    try {
      await http.delete(url ?? _url, id);
      final index = _list.indexWhere((e) => e.id == id);
      _list.removeAt(index);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  ///used mainly by the search bloc to update the current selected category or
  ///product. So that listeners can get it just by calling [productsService.getCurrent]
  ///or [categoriesService.getCurrent]
  void updateCurrent(String id) {
    final index = _list.indexWhere((e) => e.id == id);
    final item = _list[index];
    _current = item;
    notifyListeners();
  }

  ///url needs to be specified to understand whether the endpoint was directed
  ///to expenses or products categories, so that the type of category can be
  ///determined.
  ///Used only for categories
  dynamic _getValueFromJson(var json, [String? url]) {
    if (T == Product) return Product.fromJson(json);
    if (T == OpeningStockItem) return OpeningStockItem.fromJson(json);
    if (T == Category) {
      final isExpense = url!.contains('expense');
      return Category.fromJson(json, isExpense);
    }
  }

  dynamic _getInitialValue() {
    if (T == Product) return const Product();
    if (T == Category) return const Category();
    if (T == OpeningStockItem) return const OpeningStockItem();
  }
}
