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
      required Product product}) = _Sales;

  factory Sales.empty() => Sales(product: Product.empty());

  ///id is used for editing when temporarily stored in the service
  ///Id is not used when creating a sales json to be uploaded to
  ///the server.
  factory Sales.toServer(
          {required String id,
          required Product product,
          required double unitPrice,
          required double quantity}) =>
      Sales(product: product, unitPrice: unitPrice, quantity: quantity, id: id);

  String get formattedTotal => Utils.convertToMoneyFormat(quantity * unitPrice);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  Map<String, dynamic> convertToJson() {
    return {
      'quantity': quantity,
      'unitPrice': unitPrice,
      'productId': product.id,
    };
  }
}
