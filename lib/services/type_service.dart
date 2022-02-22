import '../source.dart';

class TypeService extends ChangeNotifier {
  static var _selectedType = CategoryType.expenses();

  List<CategoryType> get getCategoryTypeList => kCategoryTypesList;

  CategoryType get getSelectedType => _selectedType;

  void updateType(CategoryType type) {
    _selectedType = type;
    notifyListeners();
  }

  static final kCategoryTypesList = <CategoryType>[
    CategoryType.expenses(),
    CategoryType.products()
  ];
}
