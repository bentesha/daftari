import '../source.dart';

class WriteOffsGroupTile extends StatelessWidget {
  const WriteOffsGroupTile(this.group, this.groupAmount, {Key? key})
      : super(key: key);

  final Group group;
  final double groupAmount;

  @override
  Widget build(BuildContext context) {
    final formattedDay = DateFormatter.convertToDOW(group.date);
    final formattedAmount = Utils.convertToMoneyFormat(groupAmount);
    return AppMaterialButton(
      onPressed: () => push(GroupWriteOffsPage(group: group)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(group.title),
        subtitle: AppText(formattedDay, opacity: .7, size: 14.dw),
        trailing: AppText(formattedAmount, weight: FontWeight.bold),
      ),
    );
  }
}
