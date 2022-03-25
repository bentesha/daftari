import 'package:inventory_management/utils/error_handler_mixin.dart';
import '../source.dart';
import 'with_no_document_base_service.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

class CategoriesService extends WithNoDocumentBaseService<Category>
    with ErrorHandler {
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
      final result1 = await http.get(root + expenseCategoryEndpoint);
      final result2 = await http.get(root + productCategoryEndpoint);

      var categories1 = _addCategoriesFrom(result1, 'Expenses');
      var categories2 = _addCategoriesFrom(result2, 'Products');

      categories1 = [...categories2];
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
      final json = await http.post(url, json: item.toJson());
      final category = Category.fromJson(json, _isExpenses);
      final list = super.getList;
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
