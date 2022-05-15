import '../source.dart';

class Expense {
  final String id, documentId;
  final Category category;
  final double amount;
  final String? description;

  const Expense(
      {this.id = '',
      this.documentId = '',
      this.amount = 0.0,
      this.description,
      this.category = const Category()});

  factory Expense.toServer(
      {required String id,
      required Category category,
      required double amount,
      String? description}) {
    return Expense(
        id: id, category: category, amount: amount, description: description);
  }

  String get formattedAmount => Utils.convertToMoneyFormat(amount);

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['id'],
        category:
            Category.fromJson(json['category'], type: CategoryTypes.expenses),
        documentId: json['documentId'],
        amount: (json['amount'] as num).toDouble(),
        description: json['description']);
  }

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
      'categoryId': category.id
    };
  }

  @override
  String toString() {
    return 'Expense: category: ${category.name}, id: $id';
  }
}
