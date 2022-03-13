import '../source.dart';

class SalesEditPage extends StatefulWidget {
  const SalesEditPage(this.action, {this.sales, Key? key}) : super(key: key);

  final Sales? sales;
  final PageActions action;

  @override
  State<SalesEditPage> createState() => _SalesEditPageState();
}

class _SalesEditPageState extends State<SalesEditPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.action.toString());
    return BlocConsumer<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
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
          );
        });
  }

  Widget _buildLoading(SalesDocumentSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildBody(supp),
    );
  }

  Widget _buildBody(SalesDocumentSupplements supp) {
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

  _buildAppBar(SalesDocumentSupplements supp) {
    return PageAppBar(
        title: supp.isAdding
            ? 'New Sales Record'
            : supp.isViewing
                ? 'Sales Record'
                : 'Edit Sales Record',
        actionIcons: supp.isViewing
            ? []
            : supp.isEditing
                ? [Icons.check, Icons.delete_outlined]
                : [Icons.check],
        actionCallbacks: supp.isViewing
            ? []
            : supp.isEditing
                ? [
                    bloc.editSales,
                    bloc.deleteSales,
                  ]
                : [bloc.addSales]);
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final salesService = getService<SalesService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, productsService);
    bloc.init(Pages.sales_edit_page,
        sales: widget.sales, action: widget.action);
  }
}
