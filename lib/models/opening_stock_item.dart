import '../source.dart';

class OpeningStockItem {
  final String id, date, productId;
  final double unitValue, quantity, total;
  final String? description;

  const OpeningStockItem(
      {this.id = '',
      this.date = '',
      this.productId = '',
      this.unitValue = 0.0,
      this.quantity = 0.0,
      this.total = 0.0,
      this.description});

  factory OpeningStockItem.fromJson(Map<String, dynamic> json) =>
      OpeningStockItem(
        id: json['id'],
        date: json['date'],
        productId: json['productId'],
        unitValue: json['unitValue'].toDouble(),
        quantity: json['quantity'].toDouble(),
        total: json['total'].toDouble(),
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    String? _description;
    if (description != null) {
      //code can be '', that is empty and empty faces validation errors
      //from the server
      if (description!.isNotEmpty) _description = description!;
    }
    return {
      'date': date,
      'unitValue': unitValue,
      'quantity': quantity,
      'description': _description,
      'productId': productId
    };
  }

  String get formattedDate => DateFormatter.convertToDMY(DateTime.parse(date));

  String get formattedUnitValue => Utils.convertToMoneyFormat(unitValue);

  String get formattedTotal => Utils.convertToMoneyFormat(total);
}
