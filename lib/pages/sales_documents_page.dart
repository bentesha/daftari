import '../source.dart';

class SalesDocumentsPage extends StatefulWidget {
  const SalesDocumentsPage({Key? key}) : super(key: key);

  @override
  State<SalesDocumentsPage> createState() => _SalesDocumentsPageState();
}

class _SalesDocumentsPageState extends State<SalesDocumentsPage> {
  var bloc = SalesPagesBloc.empty();

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
        floatingActionButton: _buildFloatingButton());
  }

  Widget _buildBody() {
    return BlocConsumer<SalesPagesBloc, SalesDocumentsPageState>(
      bloc: bloc,
      listener: (_, state) {
        final error = state.maybeWhen(
            failed: (_, e, showOnPage) => showOnPage ? null : e,
            orElse: () => null);
        if (error != null) showSnackBar(error, context: context);
      },
      builder: (_, state) {
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: _buildFailed);
      },
    );
  }

  Widget _buildLoading(SalesDocumentSupplements supp) =>
      const AppLoadingIndicator();

  Widget _buildFailed(
      SalesDocumentSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

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
            sales: (_, __) => DocumentTile<Sales>(document),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<SalesPagesBloc, SalesDocumentsPageState>(
        bloc: bloc,
        builder: (_, state) {
          final shouldShowButton = state.maybeWhen(
              content: (_) => true,
              failed: (_, __, showOnPage) => !showOnPage,
              orElse: () => false);
          if (!shouldShowButton) return Container();
          return const AddButton(nextPage: DocumentSalesPage());
        });
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final salesService = getService<SalesService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = SalesPagesBloc(salesService, productsService);
    }
    bloc.init(Pages.sales_documents_page);
  }

  _tryInitAgain() => _initBloc(false);

  static const emptySalesDocumentsMessage =
      'No sales record has been added. Add one by clicking the button on a bottom-right corner.';
}
