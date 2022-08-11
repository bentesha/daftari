import '../../source.dart';

class PurchasesDocumentsPage extends StatefulWidget {
  const PurchasesDocumentsPage({Key? key}) : super(key: key);

  @override
  State<PurchasesDocumentsPage> createState() => _PurchasesDocumentsPageState();
}

class _PurchasesDocumentsPageState extends State<PurchasesDocumentsPage> {
  var bloc = PurchasesPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Purchases'),
        body: _buildBody(),
        floatingActionButton: _buildFloatingButton());
  }

  Widget _buildBody() {
    return BlocConsumer<PurchasesPagesBloc, PurchasesPagesState>(
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

  Widget _buildLoading(PurchasesPagesSupplements supp) =>
      const AppLoadingIndicator();

  Widget _buildFailed(
      PurchasesPagesSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(PurchasesPagesSupplements supp) {
    final documents = supp.documents;
    if (documents.isEmpty) {
      return const EmptyStateWidget(message: emptyPurchasesDocumentsMessage);
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final document = documents[index];
        return document.maybeWhen(
            purchases: (_, __) => DocumentTile<Purchase>(document),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<PurchasesPagesBloc, PurchasesPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final shouldShowButton = state.maybeWhen(
              content: (_) => true,
              failed: (_, __, showOnPage) => !showOnPage,
              orElse: () => false);
          if (!shouldShowButton) return Container();
          return const AddButton(nextPage: DocumentPurchasesPage());
        });
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final purchasesService = getService<PurchasesService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = PurchasesPagesBloc(purchasesService, productsService);
    }
    bloc.init(Pages.purchases_documents_page);
  }

  _tryInitAgain() => _initBloc(false);

  static const emptyPurchasesDocumentsMessage =
      'No purchases record has been added. Add one by clicking the button on a bottom-right corner.';
}
