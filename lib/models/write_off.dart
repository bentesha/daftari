import 'package:inventory_management/source.dart';

part 'write_off.g.dart';

@HiveType(typeId: 5)
class WriteOff {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String groupId;

  @HiveField(2)
  final Product product;

  @HiveField(3)
  final double quantity;

  WriteOff(
      {required this.id,
      required this.groupId,
      required this.product,
      required this.quantity});

  factory WriteOff.empty() =>
      WriteOff(id: '', groupId: '', product: Product.empty(), quantity: 0.0);

  double get amount => product.unitPrice * quantity;
}
