import 'package:inventory_management/utils/error_handler_mixin.dart';
import '../source.dart';
import 'with_no_document_base_service.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

class CategoriesService extends WithNoDocumentBaseService<Category>
    with ErrorHandler {
  static late CategoryTypes _categoryType;
  static const expenseCategoryEndpoint = 'expenseCategory';
  static const productCategoryEndpoint = 'category';

  static bool get _isExpenses => _categoryType == CategoryTypes.expenses;

  static initType(CategoryTypes type) {
    _categoryType = type;
    log('Type: $type');
  }

  ///Gets all categories from the server
  Future<void> init() async => await getAll();

  @override
  Future<void> getAll() async {
    if (super.getList.isNotEmpty) return;

    try {
      final result1 = await http.get(root + expenseCategoryEndpoint) as List;
      final result2 = await http.get(root + productCategoryEndpoint) as List;

      var expenseCategories =
          _getCategoriesFrom(result1, CategoryTypes.expenses);
      var productsCategories =
          _getCategoriesFrom(result2, CategoryTypes.products);
      final categories = [...expenseCategories, ...productsCategories];
      updateAttributes(categories);
    } catch (e) {
      throw getError(e);
    }
  }

  @override
  Future<void> add(var item) async {
    try {
      final url = root +
          (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
      final json = await http.post(url, jsonItem: item.toJson());
      final category = Category.fromJson(json, type: _categoryType);
      final list = super.getList;
      list.add(category);
      updateAttributes(list, currentId: category.id);
      notifyListeners();
    } catch (e) {
      throw getError(e);
    }
  }

  @override
  Future<void> edit(var item, [String? url]) async {
    final url = root +
        (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
    await edit(item, url);
  }

  @override
  Future<void> delete(String id, [String? url]) async {
    final url = root +
        (_isExpenses ? expenseCategoryEndpoint : productCategoryEndpoint);
    await delete(id, url);
  }

  List<Category> _getCategoriesFrom(List result, CategoryTypes categoryType) {
    final list = result
        .map((category) => Category.fromJson(category, type: categoryType));
    return list.whereType<Category>().toList();
  }
}
