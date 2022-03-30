
import '../source.dart';

part 'freezed_models/search_page_supplements.freezed.dart';

@freezed
class SearchPageSupplements<T> with _$SearchPageSupplements<T> {
  const factory SearchPageSupplements({
    required String query,
    required List<T> options,
  }) = _SearchPageSupplements;

  factory SearchPageSupplements.empty() =>
       SearchPageSupplements<T>(query: '', options: []);
}
