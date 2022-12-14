import 'package:inventory_management/models/source.dart';

import '../utils/utils.dart';

part 'write_off.freezed.dart';
part 'write_off.g.dart';

@freezed
class WriteOff with _$WriteOff {
  const WriteOff._();

  const factory WriteOff(
      {@Default('') String id,
      @Default('') String documentId,
      @Default('') String productId,
      @Default(0.0) double unitCost,
      @Default(0.0) double quantity}) = _WriteOff;

  factory WriteOff.fromJson(Map<String, dynamic> json) =>
      _$WriteOffFromJson(json);

  factory WriteOff.toServer(
          {required String id,
          required String productId,
          required double quantity}) =>
      WriteOff(productId: productId, quantity: quantity, id: id);

  String get formattedTotal => Utils.convertToMoneyFormat(calcTotal);

  double get calcTotal => quantity * unitCost;

  Map<String, dynamic> convertToJson() {
    return {'quantity': quantity, 'productId': productId};
  }
}
