import '../pages/group_expenses_page.dart';
import '../source.dart';

class ExpensesGroupTile extends StatelessWidget {
  const ExpensesGroupTile(this.group, this.groupAmount, {Key? key})
      : super(key: key);

  final Document group;
  final double groupAmount;

  @override
  Widget build(BuildContext context) {
    final formattedDay = DateFormatter.convertToDOW(group.form.date);
    final formattedAmount = Utils.convertToMoneyFormat(groupAmount);
    return AppMaterialButton(
      onPressed: () =>push(GroupExpensesPage(group: group)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(group.form.title),
        subtitle: AppText(formattedDay, opacity: .7, size: 14.dw),
        trailing: AppText(formattedAmount, weight: FontWeight.bold),
      ),
    );
  }
}
