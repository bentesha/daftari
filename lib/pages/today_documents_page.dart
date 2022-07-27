import '../repository/reports/sales/sales_repository.dart';
import '../source.dart';

class TodayDocumentsPage extends StatefulWidget {
  const TodayDocumentsPage({Key? key}) : super(key: key);

  @override
  State<TodayDocumentsPage> createState() => _TodayDocumentsPageState();
}

class _TodayDocumentsPageState extends State<TodayDocumentsPage> {
  late Future<List<Document>> fetchTodaySalesDocument;

  @override
  void initState() {
    super.initState();
    fetchTodaySalesDocument = SalesRepository().getTodaySalesDocuments();
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
                                  SalesRepository().getTodaySalesDocuments();
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
                      itemBuilder: (_, index) {
                        final document = snapshot.data![index];
                        return AppText(document.form.title);
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
}
