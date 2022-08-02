import '../repository/reports/sales/sales_repository.dart';
import '../source.dart';

class TodayDocumentsPage extends StatefulWidget {
  const TodayDocumentsPage({Key? key}) : super(key: key);

  @override
  State<TodayDocumentsPage> createState() => _TodayDocumentsPageState();
}

class _TodayDocumentsPageState extends State<TodayDocumentsPage> {
  late Future<List<Document>> fetchTodaySalesDocument;
  late final ProductsService productsService;
  final selectedDocumentNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    productsService = context.read<ProductsService>();
    fetchTodaySalesDocument = _fetchTodaySalesDocument();
  }

  Future<List<Document>> _fetchTodaySalesDocument() async {
    // making sure we will get the products data from their respective ids.
    await productsService.getAll();
    return await SalesRepository().getTodaySalesDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today Sales")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<List<Document>>(
              future: fetchTodaySalesDocument,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          snapshot.error.toString(),
                          alignment: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              fetchTodaySalesDocument =
                                  _fetchTodaySalesDocument();
                              setState(() {});
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                            ),
                            child: const AppText("Try Again",
                                color: AppColors.onPrimary))
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final document = snapshot.data![index];
                        return ValueListenableBuilder(
                          valueListenable: selectedDocumentNotifier,
                          child: ListTile(
                            title: AppText(document.form.formattedDate),
                            trailing: AppText(document.form.formattedTotal,
                                weight: FontWeight.bold),
                            onTap: () => selectedDocumentNotifier.value =
                                document.form.id,
                          ),
                          builder: (_, selectedDocumentID, child) {
                            final isSelected =
                                selectedDocumentID == document.form.id;
                            if (isSelected) {
                              return _buildExpandedDocument(document);
                            } else {
                              return child!;
                            }
                          },
                        );
                      },
                    );
                  }
                }

                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Widget _buildExpandedDocument(Document document) {
    final sales = document
        .maybeWhen(sales: (_, list) => list, orElse: () => [])
        .whereType<Sales>()
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
          children: sales.map((e) {
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
