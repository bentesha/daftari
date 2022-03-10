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

  String get formattedTotal => Utils.convertToMoneyFormat(total);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
      'productId': product.id,
    };
  }
}
