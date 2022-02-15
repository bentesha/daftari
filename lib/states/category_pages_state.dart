import '../source.dart';

part 'category_pages_state.freezed.dart';

@freezed
class CategoryPagesState with _$CategoryPagesState {
  const factory CategoryPagesState.loading(Category category) = _Loading;
  const factory CategoryPagesState.content(Category category) = _Content;
  const factory CategoryPagesState.success(Category category) = _Success;

  factory CategoryPagesState.initial() => CategoryPagesState.content(Category.empty());
}