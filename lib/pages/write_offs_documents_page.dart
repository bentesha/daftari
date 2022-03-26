import '../source.dart';

class WriteOffsDocumentsPages extends StatefulWidget {
  const WriteOffsDocumentsPages({Key? key}) : super(key: key);

  @override
  State<WriteOffsDocumentsPages> createState() =>
      _WriteOffsDocumentsPagesState();
}

class _WriteOffsDocumentsPagesState extends State<WriteOffsDocumentsPages> {
  var bloc = WriteOffPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Write-offs'),
        body: _buildBody(),
        floatingActionButton: _buildFloatingButton());
  }

  Widget _buildBody() {
    return BlocConsumer<WriteOffPagesBloc, WriteOffPagesState>(
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

  Widget _buildLoading(WriteOffSupplements supp) => const AppLoadingIndicator();

  Widget _buildFailed(
      WriteOffSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(WriteOffSupplements supp) {
    final documents = supp.documents;
    if (documents.isEmpty) {
      return const EmptyStateWidget(message: emptyDocumentsMessage);
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final document = documents[index];
        return document.maybeWhen(
            writeOffs: (_, ___, __) => DocumentTile<WriteOff>(document),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<WriteOffPagesBloc, WriteOffPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final shouldShowButton = state.maybeWhen(
              content: (_) => true,
              failed: (_, __, showOnPage) => !showOnPage,
              orElse: () => false);
          if (!shouldShowButton) return Container();
          return const AddButton(nextPage: DocumentWriteOffsPage());
        });
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final writeOffsService = getService<WriteOffsService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = WriteOffPagesBloc(writeOffsService, productsService);
    }
    bloc.init(Pages.write_offs_documents_page);
  }

  _tryInitAgain() => _initBloc(false);

  static const emptyDocumentsMessage =
      'No write-off record has been added. Add one by clicking the button on a bottom-right corner.';
}
