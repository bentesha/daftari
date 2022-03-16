import '../source.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage(this.documentPageAction, {this.purchase, Key? key})
      : super(key: key);

  final Purchases? purchase;
  final PageActions documentPageAction;

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  late final PurchasesPagesBloc bloc;

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

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(message!),
        AppTextButton(
            onPressed: _initBloc,
            text: 'Try Again',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            margin: EdgeInsets.only(top: 10.dh))
      ],
    ));
  }

  Widget _buildContent(PurchasesPagesSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(PurchasesPagesSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: supp.product.name,
          error: supp.errors['product'],
          isEditable: !supp.isViewing,
          onPressed: () => push(
              ItemsSearchPage<Product>(categoryType: CategoryType.products())),
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
            isEnabled: !supp.isViewing),
        AppTextField(
            text: supp.unitPrice,
            onChanged: bloc.updateAmount,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Unit Price',
            error: supp.errors['price'],
            isUpdatingOnRebuild: true,
            isEnabled: !supp.isViewing),
      ],
    );
  }

  _buildAppBar(PurchasesPagesSupplements supp) {
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    return PageAppBar(
        title: supp.isAdding
            ? 'New Purchase Record'
            : supp.isViewing
                ? 'Purchase Record'
                : 'Edit Purchase Record',
        actionIcons: wasViewingDocument
            ? []
            : supp.isViewing
                ? [Icons.edit_outlined, Icons.delete_outlined]
                : [Icons.check],
        actionCallbacks: wasViewingDocument
            ? []
            : supp.isViewing
                ? [updateActionCallback, bloc.deletePurchase]
                : [supp.isEditing ? bloc.editPurchase : bloc.addPurchase]);
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final purchasesService = getService<PurchasesService>(context);
    bloc = PurchasesPagesBloc(purchasesService, productsService);
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.purchases_page, purchase: widget.purchase, action: action);
  }
}
