// ignore_for_file: invalid_annotation_target

import '../source.dart';

part 'sales.freezed.dart';
part 'sales.g.dart';

@freezed
class Sales with _$Sales {
  const Sales._();
  // @JsonSerializable(explicitToJson: true)
  const factory Sales(
      {@Default(0.0) double quantity,
      @Default(0.0) double unitPrice,
      @Default(0.0) double total,
      required Product product}) = _Sales;

  factory Sales.empty() => Sales(product: Product.empty());

//    double get totalAmount => unitPrice * quantity;

  // String get getSellingPrice => Utils.convertToMoneyFormat(totalAmount);

  String get getFormattedTotalAmount => Utils.convertToMoneyFormat(total);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);
}
