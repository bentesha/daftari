import '../source.dart';

part 'record.g.dart';

class RecordsTypes {
  static const expenses = 'expenses';
  static const purchases = 'purchases';
  static const sales = 'sales';
}

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
  final String type;

  @HiveField(7)
  final double sellingPrice;

  Record({
    required this.id,
    required this.product,
    required this.date,
    required this.sellingPrice,
    this.notes,
    required this.groupId,
    required this.quantity,
    required this.type,
  });

  factory Record.empty() => Record(
        id: '',
        groupId: '',
        date: DateTime.now(),
        product: Product.empty(),
        quantity: 0,
        type: RecordsTypes.sales,
        sellingPrice: 0,
      );

  Record copyWith(
          {String? id,
          double? sellingPrice,
          double? quantity,
          String? notes}) =>
      Record(
        sellingPrice: sellingPrice ?? this.sellingPrice,
        date: date,
        id: id ?? this.id,
        groupId: this.id,
        type: type,
        quantity: quantity ?? this.quantity,
        product: product,
        notes: notes,
      );

  double get totalAmount => sellingPrice * quantity;

  String get getSellingPrice => Utils.convertToMoneyFormat(sellingPrice);

  String get getFormattedTotalAmount => Utils.convertToMoneyFormat(totalAmount);
}
