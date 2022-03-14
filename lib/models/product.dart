import '../source.dart';

//did not use freezed because I needed custom toJson methods, and overriding
//toJson method is not supported yet. I had 2 options: create custom to and from
//json methods with different names like getFromJson and createToJson, because
//writing custom methods with these names (to- & from-Json) freezed detects that
//and creates the classes itself and it becomes controversial.
//Second option is to writing the boilerplate yourself.

class Product {
  final String id, name, unit, categoryId;
  final double unitPrice;
  final String? code;

  const Product(
      {this.id = '',
      this.name = '',
      this.unit = '',
      this.unitPrice = 0.0,
      this.categoryId = '',
      this.code});

  String get getUnitPrice => Utils.convertToMoneyFormat(unitPrice);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        unit: json['unit'],
        unitPrice: (json['unitPrice'] as num).toDouble(),
        categoryId: json['categoryId'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() {
    String? _code;
    if (code != null) {
      //code can be '', that is empty and empty faces validation errors
      //from the server
      if (code!.isNotEmpty) _code = code!;
    }
    return {
      'name': name,
      'unit': unit,
      'unitPrice': unitPrice,
      'code': _code,
      'categoryId': categoryId
    };
  }

  Product copyWith(
      {String? id,
      String? unit,
      String? name,
      String? code,
      String? categoryId,
      double? unitPrice}) {
    return Product(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        unitPrice: unitPrice ?? this.unitPrice,
        categoryId: categoryId ?? this.categoryId);
  }
}
