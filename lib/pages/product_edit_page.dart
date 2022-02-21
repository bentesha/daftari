import '../source.dart';

class ProductEditPage extends StatefulWidget {
  const ProductEditPage({Key? key, this.product, this.categoryId}) : super(key: key);

  final Product? product;
  final String? categoryId;

  static void navigateTo(BuildContext context, {Product? product}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ProductEditPage(product: product)));
  }

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  late final ProductPageBloc bloc;
  late final bool hasNoCategoryId;

  @override
  void initState() {
    hasNoCategoryId = widget.product == null && widget.categoryId == null;
    final service = Provider.of<ProductsService>(context, listen: false);
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    bloc = ProductPageBloc(service, categoriesService);
    bloc.init(product: widget.product, categoryId: widget.categoryId);
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

            if (isSaved) Navigator.pop(context);
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
        title: hasNoCategoryId ? 'Add Product' : 'Edit Product',
        actionCallbacks: [bloc.saveProduct]);
  }

  Widget _buildLoading(ProductPageSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ProductPageSupplements supp) {
    final errors = supp.errors;

    return ListView(padding: EdgeInsets.zero, children: [
      Column(
        children: [
          ValueSelector(
            title: 'Category',
            value: bloc.getSelectedCategory?.name,
            error: supp.errors['category'],
            isEditable: true,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ItemsSearchPage<Category>())),
          ),
          AppDivider(margin: EdgeInsets.only(bottom: 10.dh))
        ],
      ),
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
      AppTextField(
        text: supp.quantity,
        onChanged: (quantity) => bloc.updateAttributes(quantity: quantity),
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Quantity',
        error: errors['quantity'],
      ),
      BarcodeField(
          error: supp.errors['barcode'],
          text: supp.barcode,
          onChanged: (code) => bloc.updateAttributes(barcode: code)),
      _buildTotalOpeningValue(supp),
    ]);
  }

  _buildTotalOpeningValue(ProductPageSupplements supp) {
    if (!supp.canCalculateTotalPrice) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDivider(
          color: AppColors.secondary,
          margin: EdgeInsets.only(bottom: 10.dh),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.dw),
          child: const AppText('Opening Value', opacity: .7),
        ),
        Padding(
          padding: EdgeInsets.only(left: 19.dw, top: 10.dh),
          child: AppText(supp.getQuantityValue,
              weight: FontWeight.w500, size: 20.dw),
        )
      ],
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
}
