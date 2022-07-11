import 'product.dart';

class InventoryMovement {
  final String id, type;
  final int inBound;
  final Product product;

  const InventoryMovement(
      {required this.id,
      required this.type,
      required this.inBound,
      required this.product});

  factory InventoryMovement.fromMap(Map<String, dynamic> rawMap) {
    return InventoryMovement(
        id: rawMap['InventoryMovement.id'],
        type: rawMap['InventoryMovement.documentType'],
        inBound: (rawMap['InventoryMovement.inbound'] as num).toInt(),
        product: Product.fromInventoryMovementJson(rawMap));
  }
}
