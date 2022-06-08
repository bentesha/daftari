import '../source.dart';
import '../widgets/form_cell_item_picker.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage(this.documentPageAction, {this.purchase, Key? key})
      : super(key: key);

  final Purchase? purchase;
  final PageActions documentPageAction;

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  var bloc = PurchasesPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchasesPagesBloc, PurchasesPagesState>(
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
        });
  }

  Widget _buildLoading(PurchasesPagesSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      PurchasesPagesSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(PurchasesPagesSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(PurchasesPagesSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        FormCellItemPicker(
          label: 'Product',
          valueText: supp.product.name,
          errorText: supp.errors['product'],
          editable: !action.isViewing,
          onPressed: () => push(const ItemsSearchPage<Product>(
              categoryType: CategoryTypes.products)),
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            text: supp.quantity,
            onChanged: bloc.updateQuantity,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Quantity',
            error: supp.errors['quantity'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
        AppTextField(
            text: supp.unitPrice,
            onChanged: bloc.updateAmount,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Unit Price',
            error: supp.errors['price'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
      ],
    );
  }

  _buildAppBar(PurchasesPagesSupplements supp) {
    final action = supp.action;
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    final title = action.isAdding
        ? 'New Purchase Record'
        : action.isViewing
            ? 'Purchase Record'
            : 'Edit Purchase Record';

    return PageAppBar.onModelPage(
        title: title,
        action: action,
        wasViewingDocument: wasViewingDocument,
        updateActionCallback: updateActionCallback,
        deleteModelCallback: bloc.deletePurchase,
        saveModelCallback: bloc.addPurchase,
        editModelCallback: bloc.editPurchase);
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final productsService = getService<ProductsService>(context);
      final purchasesService = getService<PurchasesService>(context);
      bloc = PurchasesPagesBloc(purchasesService, productsService);
    }
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.purchases_page, purchase: widget.purchase, action: action);
  }

  _tryInitAgain() => _initBloc(false);
}
