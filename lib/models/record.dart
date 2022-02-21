import '../source.dart';

part 'record.g.dart';

@HiveType(typeId: 1)
class Record {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String groupId;

  @HiveField(2)
  final String? notes;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Product product;

  @HiveField(5)
  final double quantity;

  @HiveField(6)
  final double sellingPrice;

  Record({
    required this.id,
    required this.product,
    required this.date,
    required this.sellingPrice,
    this.notes,
    required this.groupId,
    required this.quantity,
  });

  factory Record.empty() => Record(
        id: '',
        groupId: '',
        date: DateTime.now(),
        product: Product.empty(),
        quantity: 0,
        sellingPrice: 0,
      );

  Record copyWith(
      {String? id, double? sellingPrice, double? quantity, String? notes}) {
    return Record(
      sellingPrice: sellingPrice ?? this.sellingPrice,
      date: date,
      id: id ?? this.id,
      groupId: groupId,
      quantity: quantity ?? this.quantity,
      product: product,
      notes: notes,
    );
  }

  double get totalAmount => sellingPrice * quantity;

  String get getSellingPrice => Utils.convertToMoneyFormat(sellingPrice);

  String get getFormattedTotalAmount => Utils.convertToMoneyFormat(totalAmount);
}
