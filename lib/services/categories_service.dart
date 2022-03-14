import '../source.dart';
import 'constants.dart';
import 'network_service.dart';
import 'package:http/http.dart' as http;

class CategoriesService extends NetworkService<Category> {
  static bool _isExpenses = false;
  static const expenseCategoryEndpoint = 'expenseCategory';
  static const productCategoryEndpoint = 'category';

  static initType(bool isExpenses) {
    _isExpenses = isExpenses;
    log('isExpenses: $isExpenses');
  }

  ///Gets all categories from the server
  Future<void> init() async => await getAll();

  @override
  Future<List<Category>> getAll([bool isRefreshing = false]) async {
    if (super.getList.isNotEmpty) return super.getList;

    const expenseCategoriesUrl = root + expenseCategoryEndpoint;
    const productCategoriesUrl = root + productCategoryEndpoint;
    final response1 = await http.get(Uri.parse(expenseCategoriesUrl));
    final response2 = await http.get(Uri.parse(productCategoriesUrl));

    final result1 = json.decode(response1.body);
    final result2 = json.decode(response2.body);
    final categories1 = _addCategoriesFrom(result1, 'Expenses');
    final categories2 = _addCategoriesFrom(result2, 'Products');

    categories1.addAll(categories2);
    super.updateAttributes(categories1);
    return categories1;
  }

  @override
  Future<void> add(var item) async {
    final url = root +
        (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
    final response = await http.post(Uri.parse(url),
        body: json.encode(item.createJson()), headers: headers);
    // log(response.body.toString());
    final jsonCategory = json.decode(response.body);

    final list = super.getList;
    list.add(Category.fromJson(jsonCategory, _isExpenses));
    super.updateAttributes(list, currentId: item.id);
    notifyListeners();
  }

  @override
  Future<void> edit(var item, [String? url]) async {
    final url = root +
        (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
    await super.edit(item, url);
  }

  @override
  Future<void> delete(String id, [String? url]) async {
    final url = root +
        (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
    await super.delete(id, url);
  }

  List<Category> _addCategoriesFrom(var result, String categoryType) {
    final list = <Category>[];
    for (var item in result) {
      final index = list.indexWhere((e) => e.id == item['id']);
      if (index == -1) {
        list.add(Category.fromJson(item, categoryType == 'Expenses'));
      }
    }
    return list;
  }
}
