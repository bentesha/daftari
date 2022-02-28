import '../source.dart';

part 'opening_stock_pages_state.freezed.dart';

@freezed
class OpeningStockPagesState with _$OpeningStockPagesState {
  const factory OpeningStockPagesState.loading(
      OpeningStockSupplements supplements) = _Loading;
  const factory OpeningStockPagesState.content(
      OpeningStockSupplements supplements) = _Content;
  const factory OpeningStockPagesState.success(
      OpeningStockSupplements supplements) = _Success;

  factory OpeningStockPagesState.initial() =>
      OpeningStockPagesState.content(OpeningStockSupplements.empty());
}
