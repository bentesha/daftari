import '../source.dart';

class TypeService extends ChangeNotifier {
  static var _selectedType = CategoryType.expenses();

  List<CategoryType> get getCategoryList => Constants.kCategoryTypesList;

  CategoryType get getSelectedType => _selectedType;

  void updateType(CategoryType type) {
    _selectedType = type;
    notifyListeners();
  }
}
