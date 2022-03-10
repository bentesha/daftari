import '../source.dart';

class WriteOffsGroupTile extends StatelessWidget {
  const WriteOffsGroupTile(this.group, this.groupAmount, {Key? key})
      : super(key: key);

  final Document group;
  final double groupAmount;

  @override
  Widget build(BuildContext context) {
    final formattedAmount = Utils.convertToMoneyFormat(groupAmount);
    return AppMaterialButton(
      onPressed: () => push(GroupWriteOffsPage(group: group)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(group.form.title),
        subtitle: AppText(group.form.date, opacity: .7, size: 14.dw),
        trailing: AppText(formattedAmount, weight: FontWeight.bold),
      ),
    );
  }
}
