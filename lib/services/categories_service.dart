import '../source.dart';
import 'service.dart';

class CategoriesService extends Service<Category> {
  static final box = Hive.box(Constants.kCategoriesBox);
  CategoriesService() : super(box);

  static var _selectedId = '';

  List<Category> get getCategoryList => super.getList;
  String get getSelectedCategoryId => _selectedId;

  Category? getCategoryById(String id) => box.get(id) as Category?;

  Future<void> addCategory(Category category) async {
    _selectedId = category.id;
    super.add(category);
  }

  Future<void> editCategory(Category category) async => super.edit(category);

  List<Category> init() => super.getAll();

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
