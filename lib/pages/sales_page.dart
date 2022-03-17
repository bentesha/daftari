import '../source.dart';

class SalesPage extends StatefulWidget {
  const SalesPage(this.documentPageAction, {this.sales, Key? key})
      : super(key: key);

  final Sales? sales;
  final PageActions documentPageAction;

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesDocumentsPagesBloc, SalesDocumentsPageState>(
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

  Widget _buildLoading(SalesDocumentSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      SalesDocumentSupplements supp, String? message, bool isShowOnPage) {
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

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(SalesDocumentSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: supp.product.name,
          error: supp.errors['product'],
          isEditable: !action.isViewing,
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

  _buildAppBar(SalesDocumentSupplements supp) {
    final action = supp.action;
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    final title = action.isAdding
        ? 'New Sales Record'
        : action.isViewing
            ? 'Sales Record'
            : 'Edit Sales Record';

    return PageAppBar.onModelPage(
        title: title,
        action: action,
        wasViewingDocument: wasViewingDocument,
        updateActionCallback: updateActionCallback,
        deleteModelCallback: bloc.deleteSales,
        saveModelCallback: bloc.addSales,
        editModelCallback: bloc.editSales);
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final salesService = getService<SalesService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, productsService);
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.sales_page, sales: widget.sales, action: action);
  }
}
