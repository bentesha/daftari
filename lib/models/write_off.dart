import 'package:inventory_management/models/source.dart';

part 'freezed_models/write_off.freezed.dart';
part 'freezed_models/write_off.g.dart';

enum WriteOffTypes { stolen, damaged, expired, other }

extension WriteOffTypesString on WriteOffTypes {
  String get string {
    switch (this) {
      case WriteOffTypes.stolen:
        return 'Stolen';
      case WriteOffTypes.damaged:
        return 'Damaged';
      case WriteOffTypes.expired:
        return 'Expired';
      case WriteOffTypes.other:
        return 'Other';
    }
  }
}

@freezed
class WriteOff with _$WriteOff {
  const WriteOff._();

  const factory WriteOff(
      {@Default('') String id,
      @Default('') String documentId,
      @Default('') String productId,
      @Default(0.0) double quantity}) = _WriteOff;

  factory WriteOff.fromJson(Map<String, dynamic> json) =>
      _$WriteOffFromJson(json);

  factory WriteOff.toServer(
          {required String id,
          required String productId,
          required double quantity}) =>
      WriteOff(productId: productId, quantity: quantity, id: id);

  Map<String, dynamic> convertToJson() {
    return {'quantity': quantity, 'productId': productId};
  }
}
