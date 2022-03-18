import '../source.dart';

class TypesService<T> extends ChangeNotifier {
  final List<T> _typeList;
  TypesService(this._typeList) {
    _selectedType = _typeList[0];
  }

  late T _selectedType;

  List<T> get getTypeList => _typeList;

  T get getSelectedType => _selectedType;

  void updateType(T type) {
    _selectedType = type;
    notifyListeners();
  }
}

class CategoryTypesService extends TypesService<CategoryType> {
  CategoryTypesService() : super(kCategoryTypesList);

  static final kCategoryTypesList = <CategoryType>[
    CategoryType.expenses(),
    CategoryType.products()
  ];
}

class WriteOffsTypesService extends TypesService<WriteOffTypes> {
  WriteOffsTypesService() : super(kWriteOffTypesList);

  static final kWriteOffTypesList = <WriteOffTypes>[
    WriteOffTypes.damaged,
    WriteOffTypes.stolen,
    WriteOffTypes.expired,
    WriteOffTypes.other
  ];
}
