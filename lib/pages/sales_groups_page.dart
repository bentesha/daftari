import '../source.dart';

class SalesRecordsPage extends StatefulWidget {
  const SalesRecordsPage({Key? key}) : super(key: key);

  @override
  State<SalesRecordsPage> createState() => _SalesRecordsPageState();
}

class _SalesRecordsPageState extends State<SalesRecordsPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    final groupsService = getService<SalesService>(context);
    final itemsService = getService<ProductsService>(context);
    bloc = SalesDocumentsPagesBloc(groupsService, itemsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Sales'),
      floatingActionButton: const AddButton(nextPage: DocumentEditPage()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
          loading: _buildLoading,
          content: _buildContent,
          success: _buildContent,
        );
      },
    );
  }

  Widget _buildLoading(SalesDocumentSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    final documents = supp.documents;
    if (documents.isEmpty) {
      return const EmptyStateWidget(message: emptyGroupMessage);
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final document = documents[index];
        return document.maybeWhen(
            sales: (form, sales) => DocumentTile(
                document: document,
                recordList: sales,
                documentAmount: document.form.total),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  static const emptyGroupMessage =
      'No sales record has been added. Add one by clicking the button on a bottom-right corner.';
}
