import '../source.dart';

class ProductEditPage extends StatefulWidget {
  const ProductEditPage({Key? key, this.product, this.categoryId})
      : super(key: key);

  final Product? product;
  final String? categoryId;

  static void navigateTo(BuildContext context, {Product? product}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ProductEditPage(product: product)));
  }

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  late final ProductPageBloc bloc;
  late final bool hasNoCategoryId;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.product != null;
    hasNoCategoryId = widget.product == null && widget.categoryId == null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<ProductPageBloc, ProductPageState>(
          bloc: bloc,
          listener: (_, state) {
            final isSaved =
                state.maybeWhen(success: (_) => true, orElse: () => false);

            if (isSaved) pop();
          },
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                success: _buildContent);
          }),
    );
  }

  _buildAppBar() {
    return PageAppBar(
        title: hasNoCategoryId ? 'New Product' : 'Edit Product',
        actionCallbacks: [isEditing ? bloc.editProduct : bloc.saveProduct]);
  }

  Widget _buildLoading(ProductPageSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ProductPageSupplements supp) {
    return ListView(padding: EdgeInsets.zero, children: [
      _buildProductDetails(supp),
      isEditing && !supp.hasAddedOpeningStockDetails
          ? Container()
          : _buildOpeningStockDetails(supp),
    ]);
  }

  _buildProductDetails(ProductPageSupplements supp) {
    final errors = supp.errors;

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
            isEditable: true,
            onPressed: () => push(ItemsSearchPage<Category>(
                categoryType: CategoryType.products())),
          ),
          AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
          AppTextField(
            text: supp.name,
            onChanged: (name) => bloc.updateAttributes(name: name),
            hintText: 'e.g. Clothes',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'Name',
            error: errors['name'],
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  text: supp.unit,
                  onChanged: (unit) => bloc.updateAttributes(unit: unit),
                  hintText: 'ea.',
                  keyboardType: TextInputType.name,
                  shouldShowErrorText: false,
                  label: 'Unit',
                  error: errors['unit'],
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
                ),
              ),
            ],
          ),
          _buildUnitTextFieldsErrors(errors),
          BarcodeField(
              error: supp.errors['code'],
              text: supp.code,
              onChanged: (code) => bloc.updateAttributes(code: code)),
        ],
      ),
    );
  }

  _buildOpeningStockDetails(ProductPageSupplements supp) {
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
          isEditable: !isEditing,
          date: supp.openingStockItem.date),
      SizedBox(height: 8.dh),
      AppTextField(
        text: supp.quantity,
        onChanged: (quantity) => bloc.updateAttributes(quantity: quantity),
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Quantity',
        isEnabled: !isEditing,
        error: errors['quantity'],
      ),
      AppTextField(
        text: supp.quantity,
        onChanged: (value) => bloc.updateAttributes(unitValue: value),
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Unit Value',
        isEnabled: !isEditing,
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
    bloc.init(product: widget.product);
  }
}
