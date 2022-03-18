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
            ? DocumentSalesPage(document)
            : T == Purchase
                ? DocumentPurchasesPage(document)
                : T == Expense
                    ? DocumentExpensesPage(document)
                    : DocumentWriteOffsPage(document)),
        padding: EdgeInsets.symmetric(horizontal: 15.dw),
        child: ListTile(
          title: AppText(form.title, color: AppColors.secondary),
          trailing: T != WriteOff
              ? AppText(form.formattedTotal, weight: FontWeight.bold)
              : const SizedBox(width: .0001),
        ));
  }
}
