import '../source.dart';

part 'expense.g.dart';

@HiveType(typeId: 4)
class Expense {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String categoryId;

  @HiveField(2)
  final String? notes;

  @HiveField(4)
  final double amount;

  @HiveField(5)
  final String groupId;

  Expense(
      {required this.id,
      required this.groupId,
      required this.amount,
      this.notes,
      required this.categoryId});

  factory Expense.empty() =>
      Expense(id: '', categoryId: '', amount: 0, groupId: '');

  @override
  String toString() {
    return 'amount: $amount';
  }
}
