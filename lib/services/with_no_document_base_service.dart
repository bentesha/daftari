import 'constants.dart';
import '../source.dart';
import 'package:http/http.dart' as http;

class WithNoDocumentBaseService<T> extends ChangeNotifier {
  WithNoDocumentBaseService() {
    _current = _getInitialValue();
  }

  var _list = [];
  late T _current;

  String get _path => T == Product ? 'product' : '';
  String get _url => root + _path;
  List<T> get getList => _list.whereType<T>().toList();
  T get getCurrent => _current!;

  Future<List<T>> getAll([bool isRefreshing = false]) async {
    if (_list.isNotEmpty) return getList;

    final response = await http.get(Uri.parse(_url));
    //log(response.body.toString());
    final results = json.decode(response.body);
    if (results.isEmpty) return [];

    for (var item in results) {
      final index = _list.indexWhere((e) => e.id == item['id']);
      if (index == -1) _list.add(_getValueFromJson(item));
    }
    return _list.whereType<T>().toList();
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
    final response = await http.post(Uri.parse(_url),
        body: json.encode(item.toJson()), headers: headers);
    //  log(response.body);
    final body = json.decode(response.body);
    _current = _getValueFromJson(body);
    _list.add(_current);
    notifyListeners();
  }

  Future<void> edit(var item, [String? url]) async {
    final response = await http.put(Uri.parse((url ?? _url) + '/${item.id}'),
        body: json.encode(item.toJson()), headers: headers);
    // log(response.body);
    final index = _list.indexWhere((e) => e.id == item.id);
    final body = json.decode(response.body);
    _list[index] = _getValueFromJson(body, url);
    notifyListeners();
  }

  Future<void> delete(String id, [String? url]) async {
    final response = await http.delete(Uri.parse((url ?? _url) + '/$id'));
    //log(response.body);
    _handleStatusCodes(response.statusCode);
    final index = _list.indexWhere((e) => e.id == id);
    _list.removeAt(index);
    notifyListeners();
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
    if (T == Category) {
      final isExpense = url!.contains('expense');
      return Category.fromJson(json, isExpense);
    }
  }

  void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 400) throw ApiErrors.invalidDelete();
    throw ApiErrors.unknown();
  }

  dynamic _getInitialValue() {
    if (T == Product) return const Product();
    if (T == Category) return const Category();
  }
}
