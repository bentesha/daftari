import '../source.dart';
import 'network_service.dart';

class CategoriesService extends NetworkService<Category> {
  CategoriesService() : super();

  static var _selectedId = '';
  static var _category = Category.empty();

  String get getSelectedCategoryId => _selectedId;
  Category get getCurrent => _category;

  Future<void> addCategory(Category category) async {
    await super.add(category);
    _selectedId = category.id;
    _category = category;
  }

  ///Gets all categories from the Hive database
  Future<void> init() async => await super.getAll();

  void updateId(String id) {
    _selectedId = id;
    _category = super.getList.where((e) => e.id == id).toList().first;
    notifyListeners();
  }
}
