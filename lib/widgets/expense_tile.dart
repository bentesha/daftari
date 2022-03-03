import '../source.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(this.expense, {this.category, Key? key}) : super(key: key);

  final Category? category;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = Utils.convertToMoneyFormat(expense.amount);
    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(category!.name),
            trailing: AppText(formattedAmount, weight: FontWeight.bold)),
        onPressed: () => push(ExpenseEditPage(expense: expense)));
  }
}
