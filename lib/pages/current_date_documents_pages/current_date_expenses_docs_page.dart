import 'package:inventory_management/repository/reports/expenses/expenses_repository.dart';
import 'package:inventory_management/widgets/init_future_builder.dart';

import '../../source.dart';

class CurrentDateExpensesDocsPage extends StatefulWidget {
  const CurrentDateExpensesDocsPage({Key? key}) : super(key: key);

  @override
  State<CurrentDateExpensesDocsPage> createState() =>
      _CurrentDateExpensesDocsPageState();
}

class _CurrentDateExpensesDocsPageState
    extends State<CurrentDateExpensesDocsPage> {
  late final CategoriesService categoryService;
  final selectedDocumentNotifier = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    categoryService = context.read<CategoriesService>();
  }

  Future<List<Document>> _futureInit() async {
    // making sure we will get the products data from their respective ids.
    await categoryService.getAll();
    return await ExpensesRepository().getTodayExpensesDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today Expenses")),
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
    final expenses = document
        .maybeWhen(expenses: (_, list) => list, orElse: () => [])
        .whereType<Expense>()
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
          children: expenses.map((e) {
            final category = categoryService.getById(e.categoryId)!;

            return ListTile(
              title: AppText(category.name),
              trailing: AppText(Utils.convertToMoneyFormat(e.amount)),
            );
          }).toList(),
        )
      ],
    );
  }
}
