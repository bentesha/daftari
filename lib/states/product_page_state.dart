import '../source.dart';

part 'product_page_state.freezed.dart';

@freezed
class ProductPageState with _$ProductPageState {
  const factory ProductPageState.loading(ProductPageSupplements supplements) = _Loading;
  const factory ProductPageState.content(ProductPageSupplements supplements) = _Content;
  const factory ProductPageState.success(ProductPageSupplements supplements) = _Success;
  const factory ProductPageState.failed(ProductPageSupplements supplements, {String? message}) = _Failed;

  factory ProductPageState.initial() =>
      ProductPageState.content(ProductPageSupplements.empty());
}
