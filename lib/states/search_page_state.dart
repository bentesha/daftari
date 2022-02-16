import '../source.dart';

part 'search_page_state.freezed.dart';

@freezed
class SearchPageState<T> with _$SearchPageState<T> {
  const factory SearchPageState.loading(SearchPageSupplements<T> supplements) = _Loading;
  const factory SearchPageState.content(SearchPageSupplements<T> supplements) = _Content;
  const factory SearchPageState.success(SearchPageSupplements<T> supplements) = _Success;

   factory SearchPageState.initial() => SearchPageState.content(SearchPageSupplements.empty());
}
