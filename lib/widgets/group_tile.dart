import '../source.dart';

class DocumentTile extends StatelessWidget {
  const DocumentTile(
      {Key? key,
      required this.document,
      required this.documentAmount,
      required this.recordList})
      : super(key: key);

  final Document document;
  final List<Sales> recordList;
  final double documentAmount;

  @override
  Widget build(BuildContext context) {
    final title = document.form.title;
    final formatteddocumentAmount = Utils.convertToMoneyFormat(documentAmount);

    return AppTextButton(
        isFilled: false,
        onPressed: () => push(GroupRecordsPage(document)),
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 15.dh),
        child: Row(
          children: [
            AppText(title, color: AppColors.secondary),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(formatteddocumentAmount, weight: FontWeight.bold)
              ],
            ))
          ],
        ));
  }
}
