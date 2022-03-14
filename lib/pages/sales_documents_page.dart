import '../source.dart';

class SalesDocumentsPage extends StatefulWidget {
  const SalesDocumentsPage({Key? key}) : super(key: key);

  @override
  State<SalesDocumentsPage> createState() => _SalesDocumentsPageState();
}

class _SalesDocumentsPageState extends State<SalesDocumentsPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Sales'),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
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

  Widget _buildLoading(SalesDocumentSupplements supp) =>
      const AppLoadingIndicator();

  Widget _buildContent(SalesDocumentSupplements supp) {
    final documents = supp.documents;
    if (documents.isEmpty) {
      return const EmptyStateWidget(message: emptySalesDocumentsMessage);
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final document = documents[index];
        return document.maybeWhen(
            sales: (_, __) => DocumentTile(document),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final isLoading =
              state.maybeWhen(loading: (_) => true, orElse: () => false);
          if (isLoading) return Container();
          return const AddButton(nextPage: DocumentSalesPage());
        });
  }

  _initBloc() {
    final groupsService = getService<SalesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = SalesDocumentsPagesBloc(groupsService, productsService);
    bloc.init(Pages.sales_documents_page);
  }

  static const emptySalesDocumentsMessage =
      'No sales record has been added. Add one by clicking the button on a bottom-right corner.';
}
