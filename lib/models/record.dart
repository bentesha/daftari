import '../source.dart';

part 'record.g.dart';

class RecordsTypes {
  static const expenses = 'expenses';
  static const purchases = 'purchases';
  static const sales = 'sales';
}

@HiveType(typeId: 1)
class Record extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? notes;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final Item item;

  @HiveField(4)
  final double quantity;

  @HiveField(5)
  final String type;

  @HiveField(6)
  final double sellingPrice;

  Record({
    required this.id,
    required this.item,
    required this.date,
    required this.sellingPrice,
    this.notes,
    required this.quantity,
    required this.type,
  });

  factory Record.empty() => Record(
        id: '',
        date: DateTime.now(),
        item: Item.empty(),
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
        type: type,
        quantity: quantity ?? this.quantity,
        item: item,
        notes: notes,
      );

  double get totalAmount => sellingPrice * quantity;

  String get getSellingPrice => Utils.convertToMoneyFormat(sellingPrice);

  String get getFormattedTotalAmount => Utils.convertToMoneyFormat(totalAmount);
}
