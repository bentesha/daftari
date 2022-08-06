import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';
import '../widgets/date_picker_form_cell.dart';
import '../widgets/items_title.dart';

class DocumentSalesPage extends StatefulWidget {
  const DocumentSalesPage({this.document, Key? key}) : super(key: key);

  final Document? document;

  @override
  State<DocumentSalesPage> createState() => _DocumentSalesPageState();
}

class _DocumentSalesPageState extends State<DocumentSalesPage> {
  var bloc = SalesPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePop,
      child: Scaffold(
        body: BlocConsumer<SalesPagesBloc, SalesDocumentsPageState>(
            bloc: bloc,
            listener: (_, state) {
              final isSuccessful =
                  state.maybeWhen(success: (_) => true, orElse: () => false);

              if (isSuccessful) {
                final message = state.supplements.action.isAdding
                    ? 'Sales document was added successfully'
                    : state.supplements.action.isEditing
                        ? 'Sales document was editted successfully'
                        : 'Sales document was deleted successfully';
                showSnackBar(message, context: _, isError: false);
                pop();
              }

              final error = state.maybeWhen(
                  failed: (_, e, showOnPage) => showOnPage ? null : e,
                  orElse: () => null);
              if (error != null) showSnackBar(error, context: _);
            },
            builder: (_, state) {
              return state.when(
                  loading: _buildLoading,
                  content: _buildContent,
                  success: _buildContent,
                  failed: _buildFailed);
            }),
      ),
    );
  }

  Widget _buildLoading(SalesDocumentSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      SalesDocumentSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Scaffold(
        appBar: _buildAppBar(supp),
        body: _buildGroupDetails(supp),
        bottomNavigationBar: BottomTotalAmountTile(supp.document.form.total));
  }

  _buildAppBar(SalesDocumentSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.formattedDate
        : action.isEditing
            ? 'Edit Sales Document'
            : 'New Sales Document';

    return PageAppBar.onDocumentPage(
        title: title,
        action: action,
        updateActionCallback: () => bloc.updateAction(PageActions.editing),
        deleteDocumentCallback: bloc.deleteDocument,
        saveDocumentCallback: bloc.saveDocument,
        editDocumentCallback: bloc.editDocument);
  }

  Widget _buildGroupDetails(SalesDocumentSupplements supp) {
    final action = supp.action;

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // if (action.isEditing || action.isAdding)
        DatePickerFormCell(
          label: "Date",
          value: supp.date,
          enabled: action.isEditing || action.isAdding,
          onChanged: (value) {
            if (value == null) return;
            bloc.updateDate(value);
          },
        ),
        const AppDivider(margin: EdgeInsets.zero),
        SizedBox(height: 15.dh),
        AppTextField(
            text: supp.document.form.description,
            onChanged: bloc.updateNotes,
            hintText: '',
            keyboardType: TextInputType.text,
            label: 'Comment',
            error: supp.errors['comment'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
        ItemsListTitle(
            title: "ITEMS",
            enabled: action.isEditing || action.isAdding,
            onPressed: () => push(const SalesPage(PageActions.adding))),
        _buildItems(supp)
      ],
    );
  }

  _buildItems(SalesDocumentSupplements supp) {
    final salesList = supp.getSalesList;
    if (salesList.isEmpty) return _buildEmptyState(emptySalesMessage);

    return ListView.separated(
      itemCount: salesList.length,
      separatorBuilder: (_, __) => AppDivider.onDocumentPage(),
      itemBuilder: (_, i) {
        final sales = salesList[i];
        final product = bloc.getProductById(sales.productId);
        return RecordTile<Sales>(sales,
            product: product, documentPageAction: supp.action);
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 600.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final salesService = getService<SalesService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = SalesPagesBloc(salesService, productsService);
    }
    bloc.init(Pages.document_sales_page, document: widget.document);
  }

  _tryInitAgain() => _initBloc(false);

  Future<bool> _handlePop() async {
    final hasUnSavedSales = bloc.documentHasUnsavedChanges;
    if (hasUnSavedSales) {
      showDialog(
          context: context,
          builder: (_) => DocumentAlertDialog(
                isEditing: widget.document != null,
                editDocumentCallback: bloc.editDocument,
                saveDocumentCallback: bloc.saveDocument,
                clearChangesCallback: bloc.clearChanges,
              ));
    }
    return true;
  }

  static const emptySalesMessage =
      'No sales have been added in this document yet.';
}
