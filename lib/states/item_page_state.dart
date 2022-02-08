import '../source.dart';

part 'item_page_state.freezed.dart';

@freezed
class ItemPageState with _$ItemPageState {
  const factory ItemPageState.loading(ItemSupplements supp) = _Loading;
  const factory ItemPageState.content(ItemSupplements supp) = _Content;
  const factory ItemPageState.success(ItemSupplements supp) = _Success;

  factory ItemPageState.initial() =>
      ItemPageState.content(ItemSupplements.empty());
}
