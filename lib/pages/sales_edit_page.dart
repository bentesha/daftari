import '../source.dart';

class SalesEditPage extends StatefulWidget {
  const SalesEditPage({this.sales, Key? key}) : super(key: key);

  final Sales? sales;

  @override
  State<SalesEditPage> createState() => _SalesEditPageState();
}

class _SalesEditPageState extends State<SalesEditPage> {
  late final SalesDocumentsPagesBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.sales != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'New Sales Record' : 'Edit Sales Record',
          actionCallbacks: isEditing ? [bloc.editSales] : [bloc.addSales]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) pop();
        },
        builder: (_, state) {
          log('SALES EDIT PAGE');
          log(state.toString());

          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
          );
        });
  }

  Widget _buildLoading(SalesDocumentSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: supp.product.name,
          error: supp.errors['product'],
          isEditable: !isEditing,
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
        ),
        AppTextField(
          text: supp.unitPrice,
          onChanged: bloc.updateAmount,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Unit Price',
          error: supp.errors['price'],
          isUpdatingOnRebuild: true,
        ),
      ],
    );
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final salesService = getService<SalesService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, productsService);
    bloc.init(Pages.sales_edit_page, sales: widget.sales);
  }
}
