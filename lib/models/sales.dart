// ignore_for_file: invalid_annotation_target
import '../source.dart';

part 'sales.freezed.dart';

part 'sales.g.dart';

@freezed
class Sales with _$Sales {
  const Sales._();

  // @JsonSerializable(explicitToJson: true)
  const factory Sales(
      {@Default('') String id,
      @Default('') String documentId,
      @Default(0.0) double sort,
      @Default(0.0) double quantity,
      @Default(0.0) double unitPrice,
      @Default(0.0) double total,
      @Default('') String productId}) = _Sales;

  ///id is used for editing when temporarily stored in the service
  ///this id is not used when creating a sales json to be uploaded to
  ///the server. Sales id are from the server after a successful get, post or put
  ///request. These sales are deleted after a successful operation and a
  ///documents list is replaced with one from the server.
  factory Sales.toServer(
          {required String id,
          required String productId,
          required double unitPrice,
          required double quantity}) =>
      Sales(
          productId: productId,
          unitPrice: unitPrice,
          quantity: quantity,
          id: id);

  String get formattedTotal => Utils.convertToMoneyFormat(quantity * unitPrice);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  Map<String, dynamic> convertToJson() {
    return {
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productId': productId
    };
  }
}
