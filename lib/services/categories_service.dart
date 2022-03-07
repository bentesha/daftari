import 'dart:convert';
import '../source.dart';
import 'package:http/http.dart' as http;

class CategoriesService extends ChangeNotifier {
  CategoriesService();

  static bool _isExpenses = false;

  static initType(bool isExpenses) {
    _isExpenses = isExpenses;
    log('changed the type');
  }

  static var _selectedId = '';
  static var _category = Category.empty();

  String get getSelectedCategoryId => _selectedId;
  Category get getCurrent => _category;

  ///Gets all categories from the Hive database
  Future<void> init() async => await getAll();

  void updateId(String id) {
    _selectedId = id;
    _category = _list.where((e) => e.id == id).toList().first;
    notifyListeners();
  }

  static const root = 'http://cloud.mobicap.co.tz:8080/';
  final headers = {"Content-Type": "application/json"};

  String get _path => _isExpenses ? 'expenseCategory' : 'category';

  String get _url => root + _path + '/';

  final _list = <Category>[];
  List<Category> get getList => _list;

  Future<List<Category>> getAll([bool isRefreshing = false]) async {
    final response = await http.get(Uri.parse(_url));
    final results = json.decode(response.body);

    if (results.isEmpty) return [];

    for (var item in results) {
      final index = _list.indexWhere((e) => e.id == item['id']);
      item['type'] = _isExpenses ? 'Expenses' : 'Products';
      if (index == -1) _list.add(Category.fromJson(item));
    }
    return _list;
  }

  ///updates the items list so that getList methods works for listeners
  void refresh() => getAll(true);

  Category? getById(String id) {
    final items = _list.where((e) => e.id == id).toList();
    if (items.isNotEmpty) return items.first;
    return null;
  }

  Future<void> add(Category category) async {
    final response = await http.post(Uri.parse(_url),
        body: json.encode(category.toJson()), headers: headers);
    log(response.body);
    _list.add(category);
    _selectedId = category.id;
    _category = category;
    notifyListeners();
  }

  Future<void> edit(Category category) async {
    final response = await http.put(Uri.parse(_url + category.id),
        body: json.encode(category.toJson()), headers: headers);
    log(category.description.toString());
    log(response.body);

    final index = _list.indexWhere((e) => e.id == category.id);
    _list[index] = category;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await http.delete(Uri.parse(_url + '/$id'));
    final index = _list.indexWhere((e) => e.id == id);
    _list.removeAt(index);
    notifyListeners();
  }
}
