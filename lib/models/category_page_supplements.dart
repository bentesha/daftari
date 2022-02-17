import '../source.dart';

part 'category_page_supplements.freezed.dart';

@freezed
class CategoryPageSupplements with _$CategoryPageSupplements {
  const CategoryPageSupplements._();

  const factory CategoryPageSupplements({
    required Category category,
    required List<Category> categoryList,
    required List<Product> productList,
    required Map<String, String?> errors,
  }) = _CategoryPageSupplements;

  factory CategoryPageSupplements.empty() => CategoryPageSupplements(
      category: Category.empty(), categoryList: [], productList: [], errors: {});
}
