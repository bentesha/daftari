// ignore_for_file: invalid_annotation_target
import '../source.dart';

part 'freezed_models/purchases.freezed.dart';

part 'freezed_models/purchases.g.dart';

@freezed
class Purchase with _$Purchase {
  const Purchase._();

  const factory Purchase({
    @Default('') String id,
    @Default('') String documentId,
    @Default(0.0) double sort,
    @Default(0.0) double quantity,
    @Default(0.0) double unitPrice,
    @Default(0.0) double total,
    @Default('') String productId,
    @Default('') String movementId,
  }) = _Purchase;

  factory Purchase.toServer(
          {required String id,
          required String productId,
          required double unitPrice,
          required double quantity}) =>
      Purchase(
          productId: productId,
          unitPrice: unitPrice,
          quantity: quantity,
          id: id);

  String get formattedTotal => Utils.convertToMoneyFormat(quantity * unitPrice);

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);

  Map<String, dynamic> convertToJson() {
    return {
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productId': productId
    };
  }
}
