import '../source.dart';

class Expense {
  final String id, documentId;
  final String categoryId;
  final double amount;
  final String? description;

  const Expense(
      {this.id = '',
      this.documentId = '',
      this.amount = 0.0,
      this.description,
      this.categoryId = ''});

  factory Expense.toServer(
      {required String id,
      required String categoryId,
      required double amount,
      String? description}) {
    return Expense(
        id: id,
        categoryId: categoryId,
        amount: amount,
        description: description);
  }

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
      //description can be '', that is empty and empty faces validation errors
      //from the server
      if (description!.isNotEmpty) _description = description!;
    }
    return {
      'amount': amount,
      'description': _description,
      'categoryId': categoryId
    };
  }

  @override
  String toString() {
    return 'Expense(id: $id)';
  }
}
