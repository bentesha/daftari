import '../source.dart';

class DocumentTile<T> extends StatelessWidget {
  const DocumentTile(this.document, {Key? key}) : super(key: key);

  final Document document;

  @override
  Widget build(BuildContext context) {
    final form = document.form;

    return AppTextButton(
        isFilled: false,
        onPressed: () => push(T == Sales
            ? DocumentSalesPage(document: document)
            : T == Purchase
                ? DocumentPurchasesPage(document)
                : T == Expense
                    ? DocumentExpensesPage(document: document)
                    : DocumentWriteOffsPage(document)),
        padding: EdgeInsets.symmetric(horizontal: 15.dw),
        child: ListTile(
            title: AppText(form.formattedDate, color: AppColors.secondary),
            trailing: AppText(form.formattedTotal, weight: FontWeight.bold)));
  }
}
