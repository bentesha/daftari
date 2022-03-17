import '../source.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(this.expense,
      {required this.category, required this.documentPageAction, Key? key})
      : super(key: key);

  final Category category;
  final Expense expense;
  final PageActions documentPageAction;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = Utils.convertToMoneyFormat(expense.amount);
    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(category.name),
            trailing: AppText(formattedAmount, weight: FontWeight.bold)),
        onPressed: () =>
            push(ExpensePage(documentPageAction, expense: expense)));
  }
}
