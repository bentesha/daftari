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
            : T == Purchases
                ? DocumentPurchasesPage(document)
                : DocumentExpensesPage(document)),
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 15.dh),
        child: Row(
          children: [
            AppText(form.title, color: AppColors.secondary),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [AppText(form.formattedTotal, weight: FontWeight.bold)],
            ))
          ],
        ));
  }
}
