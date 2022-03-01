import 'package:inventory_management/services/opening_stock_items_service.dart';

import '../source.dart';

class OpeningStockEditPage extends StatefulWidget {
  const OpeningStockEditPage({this.openingStockItem, Key? key})
      : super(key: key);

  final OpeningStockItem? openingStockItem;

  @override
  State<OpeningStockEditPage> createState() => _OpeningStockEditPageState();
}

class _OpeningStockEditPageState extends State<OpeningStockEditPage> {
  late final OpeningStockPagesBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.openingStockItem != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'New Item' : 'Edit Item',
          actionCallbacks: isEditing ? [bloc.editItem] : [bloc.saveItem]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<OpeningStockPagesBloc, OpeningStockPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) Navigator.pop(context);
        },
        builder: (_, state) {
          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
          );
        });
  }

  Widget _buildLoading(OpeningStockSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(OpeningStockSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: supp.openingStockItem.product.name,
          error: supp.errors['product'],
          isEditable: !isEditing,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ItemsSearchPage<Product>(
                      categoryType: CategoryType.products()))),
        ),
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.openingStockItem.date,
          isEditable: !isEditing,
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
          text: supp.unitPrice,
          onChanged: bloc.updateUnitPrice,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Unit Value',
          error: supp.errors['unitValue'],
          isUpdatingOnRebuild: true,
        ),
        AppTextField(
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Quantity',
          error: supp.errors['quantity'],
          isUpdatingOnRebuild: true,
        ),
      ],
    );
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final itemsService = getService<OpeningStockItemsService>(context);
    bloc = OpeningStockPagesBloc(itemsService, productsService);
    bloc.init(widget.openingStockItem);
  }
}
