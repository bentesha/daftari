import '../source.dart';

class OpeningStockItemPage extends StatefulWidget {
  const OpeningStockItemPage({this.openingStockItem, Key? key})
      : super(key: key);

  final OpeningStockItem? openingStockItem;

  @override
  State<OpeningStockItemPage> createState() => _OpeningStockItemPageState();
}

class _OpeningStockItemPageState extends State<OpeningStockItemPage> {
  var bloc = OpeningStockPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OpeningStockPagesBloc, OpeningStockPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) pop();
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(OpeningStockSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      OpeningStockSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildBody(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(OpeningStockSupplements supp) {
    final action = supp.action;

    return Scaffold(
      appBar: PageAppBar(
          title: action.isViewing
              ? supp.product.name
              : action.isEditing
                  ? 'Edit Opening Stock Item'
                  : 'New Opening Stock Item',
          actionIcons: action.isViewing
              ? [Icons.edit_outlined, Icons.delete_outlined]
              : [Icons.check],
          actionCallbacks: action.isViewing
              ? [() => bloc.updateAction(PageActions.editing), bloc.delete]
              : [action.isEditing ? bloc.edit : bloc.save]),
      body: _buildBody(supp),
    );
  }

  Widget _buildBody(OpeningStockSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        ValueSelector(
            title: 'Product',
            value: supp.product.name,
            error: supp.errors['product'],
            isEditable: !action.isViewing,
            onPressed: () => push(const ItemsSearchPage<Product>(
                categoryType: CategoryTypes.products))),
        DateSelector(
            title: 'Date',
            onDateSelected: (_) {},
            date: supp.date,
            isEditable: false),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            text: supp.unitValue,
            onChanged: bloc.updateUnitValue,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Unit Value',
            error: supp.errors['unitValue'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
        AppTextField(
            text: supp.quantity,
            onChanged: bloc.updateQuantity,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Quantity',
            error: supp.errors['quantity'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
      ],
    );
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final productsService = getService<ProductsService>(context);
      final itemsService = getService<OpeningStockItemsService>(context);
      bloc = OpeningStockPagesBloc(itemsService, productsService);
    }
    final action = widget.openingStockItem == null
        ? PageActions.adding
        : PageActions.viewing;
    bloc.init(Pages.opening_stock_item_page, widget.openingStockItem, action);
  }

  _tryInitAgain() => _initBloc(false);
}
