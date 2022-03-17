import '../source.dart';
import 'service_constants.dart';
import 'with_no_document_base_service.dart';
import 'package:http/http.dart' as http;

class CategoriesService extends WithNoDocumentBaseService<Category> {
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

    try {
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
    } catch (e) {
      throw getError(e);
    }
  }

  @override
  Future<void> add(var item) async {
    try {
      final url = root +
          (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
      final response = await http.post(Uri.parse(url),
          body: json.encode(item.toJson()), headers: headers);
      // log(response.body.toString());
      final jsonCategory = json.decode(response.body);

      final list = super.getList;
      final category = Category.fromJson(jsonCategory, _isExpenses);
      list.add(category);
      super.updateAttributes(list, currentId: category.id);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
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
