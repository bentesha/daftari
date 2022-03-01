import '../source.dart';
import 'service.dart';

class CategoriesService extends Service<Category> {
  static final box = Hive.box(Constants.kCategoriesBox);
  CategoriesService() : super(box);

  static var _selectedId = '';
  static var _category = Category.empty();

  String get getSelectedCategoryId => _selectedId;
  Category get getCurrent => _category;

  Future<void> addCategory(Category category) async {
    _selectedId = category.id;
    _category = category;
    await super.add(category);
  }

  ///Gets all categories from the Hive database
  void init() => super.getAll();

  void updateId(String id) {
    _selectedId = id;
    _category = super.getList.where((e) => e.id == id).toList().first;
    notifyListeners();
  }
}
