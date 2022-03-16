import '../source.dart';

part 'purchases_pages_state.freezed.dart';

@freezed
class PurchasesPagesState with _$PurchasesPagesState {
  const factory PurchasesPagesState.loading(PurchasesPagesSupplements supplements) = _Loading;
  const factory PurchasesPagesState.content(PurchasesPagesSupplements supplements) = _Content;
  const factory PurchasesPagesState.success(PurchasesPagesSupplements supplements) = _Success;
  const factory PurchasesPagesState.failed(PurchasesPagesSupplements supplements,
      {String? message, @Default(false) bool showOnPage}) = _Failed;

  factory PurchasesPagesState.initial() => PurchasesPagesState.content(PurchasesPagesSupplements.empty());
}
