import 'dart:convert';
import '../source.dart';
import 'network_service.dart';
import 'package:http/http.dart' as http;

class CategoriesService extends NetworkService<Category> {
  static bool _isExpenses = false;
  static var _selectedId = '';
  static var _category = Category.empty();

  String get getSelectedCategoryId => _selectedId;
  Category get getCurrent => _category;

  static initType(bool isExpenses) {
    _isExpenses = isExpenses;
    log('isExpenses: $isExpenses');
  }

  ///Gets all categories from the server
  Future<void> init() async => await getAll();

  void updateId(String id) {
    _selectedId = id;
    _category = super.getList.where((e) => e.id == id).toList().first;
    notifyListeners();
  }

  @override
  Future<List<Category>> getAll([bool isRefreshing = false]) async {
    if (super.getList.isNotEmpty) return super.getList;

    final expenseCategoriesUrl = root + 'expenseCategory';
    final productCategoriesUrl = root + 'category';
    final response1 = await http.get(Uri.parse(expenseCategoriesUrl));
    final response2 = await http.get(Uri.parse(productCategoriesUrl));

    final result1 = json.decode(response1.body);
    final result2 = json.decode(response2.body);
    final categories1 = _addCategoriesFrom(result1, 'Expenses');
    final categories2 = _addCategoriesFrom(result2, 'Products');

    categories1.addAll(categories2);
    super.updateList(categories1);
    return categories1;
  }

  @override
  Future<void> add(var item) async {
    final url = root + (_isExpenses ? 'expenseCategory' : 'category');
    await http.post(Uri.parse(url),
        body: json.encode(item.toJson()), headers: headers);

    _selectedId = item.id;
    _category = item;

    final list = super.getList;
    list.add(item);
    super.updateList(list);
    notifyListeners();
  }

  @override
  Future<void> edit(var item, [String? url]) async {
    final url = root + (_isExpenses ? 'expenseCategory' : 'category');
    await super.edit(item, url);
  }

  @override
  Future<void> delete(String id, [String? url]) async {
    final url = root + (_isExpenses ? 'expenseCategory' : 'category');
    await super.delete(id, url);
  }

  List<Category> _addCategoriesFrom(var result, String type) {
    final list = <Category>[];
    for (var item in result) {
      final index = list.indexWhere((e) => e.id == item['id']);
      if (index == -1) {
        item['type'] = type;
        list.add(Category.fromJson(item));
      }
    }
    return list;
  }
}
