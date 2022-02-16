import '../source.dart';

part 'category_pages_state.freezed.dart';

@freezed
class CategoryPagesState with _$CategoryPagesState {
  const factory CategoryPagesState.loading(CategoryPageSupplements supplements) = _Loading;
  const factory CategoryPagesState.content(CategoryPageSupplements supplements) = _Content;
  const factory CategoryPagesState.success(CategoryPageSupplements supplements) = _Success;

  factory CategoryPagesState.initial() => CategoryPagesState.content(CategoryPageSupplements.empty());
}