import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';

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
        floatingActionButton: _buildActionButton(supp),
        bottomNavigationBar: _buildBottomNavBar(supp));
  }

  _buildAppBar(PurchasesPagesSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.title
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
      children: [
        action.isEditing || action.isAdding
            ? DateSelector(
                title: 'Date',
                onDateSelected: bloc.updateDate,
                date: supp.date,
                isEditable: /*!hasDocument*/ false,
              )
            : Container(),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
        _buildItems(supp)
      ],
    );
  }

  _buildGroupTitle(PurchasesPagesSupplements supp) {
    return supp.action.isViewing
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckBox(supp),
              supp.isDateAsTitle
                  ? Container()
                  : AppTextField(
                      text: supp.document.form.title,
                      onChanged: bloc.updateTitle,
                      hintText: '',
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      label: 'Title',
                      error: supp.errors['title']),
            ],
          );
  }

  _buildCheckBox(PurchasesPagesSupplements supp) {
    final text =
        supp.isDateAsTitle ? 'Date used as title' : 'Use date as title';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.dw),
      child: Row(
        children: [
          Checkbox(
              value: supp.isDateAsTitle, onChanged: bloc.updateDateAsTitle),
          SizedBox(width: 5.dw),
          AppText(text),
        ],
      ),
    );
  }

  _buildItems(PurchasesPagesSupplements supp) {
    final purchaseList = supp.getPurchaseList;
    if (purchaseList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        supp.action.isViewing
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 19.dw),
                child: const AppText('Purchases', weight: FontWeight.bold),
              ),
        ListView.separated(
          itemCount: purchaseList.length,
          separatorBuilder: (_, __) =>
              const AppDivider(margin: EdgeInsets.zero),
          itemBuilder: (_, i) {
            final purchase = purchaseList[i];
            final product = bloc.getProductById(purchase.productId);
            return RecordTile<Purchase>(purchase,
                product: product, documentPageAction: supp.action);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 600.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
  }

  _buildActionButton(PurchasesPagesSupplements supp) {
    return supp.action.isViewing
        ? Container()
        : const AddButton(nextPage: PurchasesPage(PageActions.adding));
  }

  _buildBottomNavBar(PurchasesPagesSupplements supp) {
    return supp.action.isViewing
        ? BottomTotalAmountTile(supp.document.form.total)
        : const SizedBox(height: .00001);
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
