import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';
import '../widgets/date_picker_form_cell.dart';

class DocumentPurchasesPage extends StatefulWidget {
  const DocumentPurchasesPage([this.document, Key? key]) : super(key: key);

  final Document? document;

  @override
  State<DocumentPurchasesPage> createState() => _DocumentPurchasesPageState();
}

class _DocumentPurchasesPageState extends State<DocumentPurchasesPage> {
  var bloc = PurchasesPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePop,
      child: BlocConsumer<PurchasesPagesBloc, PurchasesPagesState>(
          bloc: bloc,
          listener: (_, state) {
            final isSuccessful =
                state.maybeWhen(success: (_) => true, orElse: () => false);

            if (isSuccessful) pop();

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
          }),
    );
  }

  Widget _buildLoading(PurchasesPagesSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      PurchasesPagesSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(PurchasesPagesSupplements supp) {
    return Scaffold(
        appBar: _buildAppBar(supp),
        body: _buildGroupDetails(supp),
        bottomNavigationBar: BottomTotalAmountTile(supp.document.form.total));
  }

  _buildAppBar(PurchasesPagesSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.formattedDate
        : action.isEditing
            ? 'Edit Purchases Document'
            : 'New Purchases Document';

    return PageAppBar.onDocumentPage(
        title: title,
        action: action,
        updateActionCallback: () => bloc.updateAction(PageActions.editing),
        deleteDocumentCallback: bloc.deleteDocument,
        saveDocumentCallback: bloc.saveDocument,
        editDocumentCallback: bloc.editDocument);
  }

  Widget _buildGroupDetails(PurchasesPagesSupplements supp) {
    final action = supp.action;

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (action.isEditing || action.isAdding)
          DatePickerFormCell(
            label: "Date",
            value: supp.date,
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
        _buildItemsTitle(),
        _buildItems(supp)
      ],
    );
  }

  _buildItemsTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("ITEMS", style: TextStyle(fontSize: 18)),
          AppIconButton(
              onPressed: () => push(const PurchasesPage(PageActions.adding)),
              icon: Icons.add,
              margin: const EdgeInsets.only(bottom: 5),
              iconThemeData: const IconThemeData(color: AppColors.primary))
        ],
      ),
    );
  }

  _buildItems(PurchasesPagesSupplements supp) {
    final purchaseList = supp.getPurchaseList;
    if (purchaseList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return ListView.separated(
      itemCount: purchaseList.length,
      separatorBuilder: (_, __) => AppDivider.onDocumentPage(),
      itemBuilder: (_, i) {
        final purchase = purchaseList[i];
        final product = bloc.getProductById(purchase.productId);
        return RecordTile<Purchase>(purchase,
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
      final purchasesService = getService<PurchasesService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = PurchasesPagesBloc(purchasesService, productsService);
    }
    bloc.init(Pages.document_purchases_page, document: widget.document);
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

  static const emptyExpensesMessage =
      'No purchases have been added in this document yet.';
}
