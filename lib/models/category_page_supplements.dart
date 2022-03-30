import '../source.dart';

part 'freezed_models/category_page_supplements.freezed.dart';

@freezed
class CategoryPageSupplements with _$CategoryPageSupplements {
  const CategoryPageSupplements._();

  const factory CategoryPageSupplements({
    required Category category,
    @Default([]) List<Category> categoryList,
    @Default([]) List<Product> productList,
    @Default(PageActions.viewing) PageActions action,
    @Default({}) Map<String, String?> errors,
  }) = _CategoryPageSupplements;

  factory CategoryPageSupplements.empty() =>
      const CategoryPageSupplements(category: Category());
}
