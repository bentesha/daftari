import '../source.dart';

class CategoryTypesService extends TypesService<CategoryType> {
  CategoryTypesService() : super(kCategoryTypesList);

  static final kCategoryTypesList = <CategoryType>[
    CategoryType.expenses(),
    CategoryType.products()
  ];
}
