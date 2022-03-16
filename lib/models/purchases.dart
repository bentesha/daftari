// ignore_for_file: invalid_annotation_target
import '../source.dart';

part 'purchases.freezed.dart';

part 'purchases.g.dart';

@freezed
class Purchases with _$Purchases {
   const Purchases._();

  const factory Purchases(
      {@Default('') String id,
        @Default('') String documentId,
        @Default(0.0) double sort,
        @Default(0.0) double quantity,
        @Default(0.0) double unitPrice,
        @Default(0.0) double total,
        @Default('') String productId,
      @Default('') String movementId,
      }) = _Purchases;

  ///id is used for editing when temporarily stored in the service
  ///this id is not used when creating a sales json to be uploaded to
  ///the server. Sales id are from the server after a successful get, post or put
  ///request. These sales are deleted after a successful operation and a
  ///documents list is replaced with one from the server.
  factory Purchases.toServer(
      {required String id,
        required String productId,
        required double unitPrice,
        required double quantity}) =>
      Purchases(
          productId: productId,
          unitPrice: unitPrice,
          quantity: quantity,
          id: id);

 String get formattedTotal => Utils.convertToMoneyFormat(quantity * unitPrice);

  factory Purchases.fromJson(Map<String, dynamic> json) => _$PurchasesFromJson(json);

  Map<String, dynamic> convertToJson() {
    return {
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productId': productId
    };
  }
}
