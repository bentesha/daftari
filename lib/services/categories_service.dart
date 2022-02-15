import '../source.dart';
import 'service.dart';

class CategoriesService extends Service<Category> {
  static final box = Hive.box(Constants.kCategoriesBox);
  CategoriesService() : super(box);

  List<Category> get getCategoryList => super.getList;

  Future<void> addCategory(Category category) async => super.add(category);

  Future<void> editCategory(Category category) async => super.edit(category);

  List<Category> init() => super.getAll();
}
