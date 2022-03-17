import '../source.dart';

//did not use freezed because I needed custom toJson methods, and overriding
//toJson method is not supported yet. I had 2 options: create custom to and from
//json methods with different names like getFromJson and createToJson, because
//writing custom methods with these names (to- & from-Json) freezed detects that
//and creates the classes itself and it becomes controversial.
//Second option is to writing the boilerplate yourself.

class Expense {
  final String id, documentId, categoryId;
  final double amount;
  final String? description;

  Expense(
      {this.id = '',
      this.documentId = '',
      this.amount = 0.0,
      this.description,
      this.categoryId = ''});

  factory Expense.toServer(
          {required String id,
          required String categoryId,
          required double amount,
          String? description}) =>
      Expense(
          id: id,
          categoryId: categoryId,
          amount: amount,
          description: description);

  String get formattedAmount => Utils.convertToMoneyFormat(amount);

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
      id: json['id'],
      categoryId: json['categoryId'],
      documentId: json['documentId'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description']);

  Map<String, dynamic> convertToJson() {
    String? _description;
    if (description != null) {
      //code can be '', that is empty and empty faces validation errors
      //from the server
      if (description!.isNotEmpty) _description = description!;
    }
    return {
      'amount': amount,
      'description': _description,
      'categoryId': categoryId
    };
  }

/*   Expense copyWith(
      {
      String? unit,
      String? name,
      String? description,
      String? categoryId,
      double? unitPrice}) {
    return Product(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        unitPrice: unitPrice ?? this.unitPrice,
        categoryId: categoryId ?? this.categoryId);
  } */
}
