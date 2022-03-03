import '../source.dart';

class GroupTile extends StatelessWidget {
  const GroupTile(
      {Key? key,
      required this.group,
      required this.groupAmount,
      required this.recordList})
      : super(key: key);

  final Group group;
  final List<Record> recordList;
  final double groupAmount;

  @override
  Widget build(BuildContext context) {
    final title = group.title;
    final formattedGroupAmount = Utils.convertToMoneyFormat(groupAmount);

    return AppTextButton(
        isFilled: false,
        onPressed: () => push(GroupRecordsPage(group)),
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 15.dh),
        child: Row(
          children: [
            AppText(title, color: AppColors.secondary),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(formattedGroupAmount, weight: FontWeight.bold)
              ],
            ))
          ],
        ));
  }
}
