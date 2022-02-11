import '../source.dart';

part 'item_page_state.freezed.dart';

@freezed
class ItemPageState with _$ItemPageState {
  const factory ItemPageState.loading(ItemSupplements supplements) = _Loading;
  const factory ItemPageState.content(ItemSupplements supplements) = _Content;
  const factory ItemPageState.success(ItemSupplements supplements) = _Success;

  factory ItemPageState.initial() =>
      ItemPageState.content(ItemSupplements.empty());
}
