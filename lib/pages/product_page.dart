import '../source.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductPageBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductPageBloc, ProductPageState>(
        bloc: bloc,
        listener: (_, state) {
          final isSaved =
              state.maybeWhen(success: (_) => true, orElse: () => false);
          if (isSaved) pop();

          final error =
              state.maybeWhen(failed: (_, e) => e, orElse: () => null);
          if (error != null) showSnackBar(error, scaffoldKey: _scaffoldKey);
        },
        builder: (_, state) {
          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: (s, _) => _buildContent(s),
          );
        });
  }

  Widget _buildLoading(ProductPageSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildContent(ProductPageSupplements supp) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(supp),
      body: ListView(padding: EdgeInsets.zero, children: [
        _buildProductDetails(supp),
        _buildOpeningStockDetails(supp),
      ]),
    );
  }

  _buildAppBar(ProductPageSupplements supp) {
    return PageAppBar(
        title: supp.isViewing
            ? supp.product.name
            : supp.isAdding
                ? 'New Product'
                : 'Edit Product',
        actionIcons: supp.isViewing
            ? [Icons.edit_outlined, Icons.delete_outlined]
            : [Icons.check],
        actionCallbacks: supp.isViewing
            ? [() => bloc.updateAction(PageActions.editing), bloc.deleteProduct]
            : [supp.isEditing ? bloc.editProduct : bloc.saveProduct]);
  }

  _buildProductDetails(ProductPageSupplements supp) {
    final errors = supp.errors;
    final product = supp.product;

    return Padding(
      padding: EdgeInsets.only(top: 10.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 19.dw),
            child: const AppText('PRODUCT DETAILS',
                weight: FontWeight.bold, opacity: .7),
          ),
          SizedBox(height: 10.dh),
          ValueSelector(
            title: 'Category',
            value: bloc.getSelectedCategory?.name,
            error: supp.errors['category'],
            isEditable: !supp.isViewing,
            onPressed: () => push(ItemsSearchPage<Category>(
                categoryType: CategoryType.products())),
          ),
          AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
          !supp.isViewing
              ? AppTextField(
                  text: product.name,
                  onChanged: (name) => bloc.updateAttributes(name: name),
                  hintText: 'e.g. Clothes',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  label: 'Name',
                  error: errors['name'],
                  isEnabled: !supp.isViewing,
                )
              : Container(),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  text: product.unit,
                  onChanged: (unit) => bloc.updateAttributes(unit: unit),
                  hintText: 'ea.',
                  keyboardType: TextInputType.name,
                  shouldShowErrorText: false,
                  label: 'Unit',
                  error: errors['unit'],
                  isEnabled: !supp.isViewing,
                ),
              ),
              Expanded(
                child: AppTextField(
                  text: supp.unitPrice,
                  onChanged: (price) => bloc.updateAttributes(unitPrice: price),
                  hintText: '0',
                  keyboardType: TextInputType.number,
                  shouldShowErrorText: false,
                  label: 'Unit Price',
                  error: errors['unitPrice'],
                  isEnabled: !supp.isViewing,
                ),
              ),
            ],
          ),
          _buildUnitTextFieldsErrors(errors),
          BarcodeField(
              error: supp.errors['code'],
              text: product.code,
              isEnabled: !supp.isViewing,
              onChanged: (code) => bloc.updateAttributes(code: code)),
        ],
      ),
    );
  }

  _buildOpeningStockDetails(ProductPageSupplements supp) {
    if (!supp.isAdding) return Container();
    return ExpansionTile(
        title: const AppText('OPENING STOCK DETAILS',
            weight: FontWeight.bold, opacity: .7),
        children: _openingStockDetails(supp),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: EdgeInsets.symmetric(horizontal: 19.dw));
  }

  List<Widget> _openingStockDetails(ProductPageSupplements supp) {
    final errors = supp.errors;
    return [
      DateSelector(
          title: 'DATE',
          onDateSelected: (date) => bloc.updateAttributes(date: date),
          isEditable: !supp.isViewing,
          date: supp.openingStockItem.date),
      SizedBox(height: 8.dh),
      AppTextField(
        text: supp.quantity,
        onChanged: (quantity) => bloc.updateAttributes(quantity: quantity),
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Quantity',
        isEnabled: !supp.isViewing,
        error: errors['quantity'],
      ),
      AppTextField(
        text: supp.quantity,
        onChanged: (value) => bloc.updateAttributes(unitValue: value),
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Unit Value',
        isEnabled: !supp.isViewing,
        error: errors['unitValue'],
      ),
      _buildTotalOpeningValue(supp)
    ];
  }

  _buildTotalOpeningValue(ProductPageSupplements supp) {
    if (!supp.canCalculateTotalPrice) return Container();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText('Product Value', opacity: .7),
          SizedBox(height: 8.dh),
          AppText(supp.getStockValue, weight: FontWeight.bold),
          SizedBox(height: 8.dh),
        ],
      ),
    );
  }

  _buildUnitTextFieldsErrors(Map<String, String?> errors) {
    final hasUnitError = errors['unit'] != null;
    final hasUnitPriceError = errors['unitPrice'] != null;

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 10.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasUnitError) _buildErrorText(errors['unit']!),
          if (hasUnitPriceError) _buildErrorText(errors['unitPrice']!),
        ],
      ),
    );
  }

  _buildErrorText(String error) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.dh),
      child: AppText('* $error', color: AppColors.error),
    );
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final openingStockItemsService =
        getService<OpeningStockItemsService>(context);
    bloc = ProductPageBloc(
        productsService, categoriesService, openingStockItemsService);
    final action =
        widget.product == null ? PageActions.adding : PageActions.viewing;
    bloc.init(Pages.product_page, product: widget.product, action: action);
  }
}
