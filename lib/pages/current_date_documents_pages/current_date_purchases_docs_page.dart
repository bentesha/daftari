import 'package:inventory_management/repository/reports/purchases/purchases_repository.dart';
import 'package:inventory_management/widgets/init_future_builder.dart';

import '../../source.dart';

class CurrentDatePurchasesDocsPage extends StatefulWidget {
  const CurrentDatePurchasesDocsPage({Key? key}) : super(key: key);

  @override
  State<CurrentDatePurchasesDocsPage> createState() =>
      _CurrentDatePurchasesDocsPageState();
}

class _CurrentDatePurchasesDocsPageState
    extends State<CurrentDatePurchasesDocsPage> {
  late final ProductsService productsService;
  final selectedDocumentNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    productsService = context.read<ProductsService>();
  }

  Future<List<Document>> _futureInit() async {
    // making sure we will get the products data from their respective ids.
    await productsService.getAll();
    return await PurchasesRepository().getTodayPurchasesDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today Purchases")),
      body: InitFutureBuilder<List<Document>>(
        callback: _futureInit,
        builder: (_, documents) {
          return ListView.builder(
            itemCount: documents.length,
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            itemBuilder: (_, index) {
              final document = documents[index];
              return ValueListenableBuilder(
                valueListenable: selectedDocumentNotifier,
                child: ListTile(
                  title: AppText(document.form.formattedDate),
                  trailing: AppText(document.form.formattedTotal,
                      weight: FontWeight.bold),
                  onTap: () =>
                      selectedDocumentNotifier.value = document.form.id,
                ),
                builder: (_, selectedDocumentID, child) {
                  final isSelected = selectedDocumentID == document.form.id;
                  if (isSelected) {
                    return _buildExpandedDocument(document);
                  } else {
                    return child!;
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildExpandedDocument(Document document) {
    final purchases = document
        .maybeWhen(purchases: (_, list) => list, orElse: () => [])
        .whereType<Purchase>()
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(document.form.formattedDate, weight: FontWeight.bold),
            AppIconButton(
              onPressed: () => selectedDocumentNotifier.value = "",
              icon: Icons.remove,
              iconThemeData: const IconThemeData(color: Colors.black),
            )
          ],
        ),
        Column(
          children: purchases.map((e) {
            final product = productsService.getProductByID(e.productId);

            return ListTile(
              title: AppText(product.name),
              trailing: AppText(product.getUnitPrice),
            );
          }).toList(),
        )
      ],
    );
  }
}
