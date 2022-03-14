import '../source.dart';

//did not use freezed because I needed custom toJson methods, and overriding
//toJson method is not supported yet. I had 2 options: create custom to and from
//json methods with different names like getFromJson and createToJson, because
//writing custom methods with these names (to- & from-Json) freezed detects that
//and creates the classes itself and it becomes controversial.
//Second option is to writing the boilerplate yourself.

class Product {
  final String id, name, unit, categoryId, code;
  final double unitPrice;

  const Product(
      {required this.id,
      required this.name,
      required this.unit,
      required this.unitPrice,
      required this.categoryId,
      required this.code});

  factory Product.empty() => const Product(
      name: '', id: '', unit: 'ea.', unitPrice: 0.0, code: '', categoryId: '');

  String get getUnitPrice => Utils.convertToMoneyFormat(unitPrice);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        unit: json['unit'],
        unitPrice: (json['unitPrice'] as num).toDouble(),
        categoryId: json['categoryId'],
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'unit': unit,
        'unitPrice': unitPrice,
        'code': Utils.getRandomId(),
        'categoryId': categoryId
      };


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
