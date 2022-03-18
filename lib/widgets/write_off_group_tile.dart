/* import '../source.dart';

class WriteOffsGroupTile extends StatelessWidget {
  const WriteOffsGroupTile(this.document, {Key? key}) : super(key: key);

  final Document document;

  @override
  Widget build(BuildContext context) {
    final form = document.form;
    return AppMaterialButton(
      onPressed: () => push(DocumentWriteOffsPage(document: document)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(form.title),
        subtitle: AppText(form.date, opacity: .7, size: 14.dw),
        trailing: AppText(form.formattedTotal, weight: FontWeight.bold),
      ),
    );
  }
}
 */