import '../source.dart';

part 'freezed_models/category_page_supplements.freezed.dart';

@freezed
class CategoryPageSupplements with _$CategoryPageSupplements {
  const CategoryPageSupplements._();

  const factory CategoryPageSupplements({
    required Category category,
    required List<Category> categoryList,
    required List<Product> productList,
    @Default(PageActions.viewing) PageActions action,
    required Map<String, String?> errors,
  }) = _CategoryPageSupplements;

  factory CategoryPageSupplements.empty() => const CategoryPageSupplements(
      category: Category(), categoryList: [], productList: [], errors: {});

  bool get isEditing => action == PageActions.editing;

  bool get isViewing => action == PageActions.viewing;

  bool get isAdding => action == PageActions.adding;
}
