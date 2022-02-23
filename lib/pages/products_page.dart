import '../source.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late final ProductPageBloc bloc;

  @override
  void initState() {
    final service = getService<ProductsService>(context);
    final categoriesService = getService<CategoriesService>(context);
    bloc = ProductPageBloc(service, categoriesService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Items'),
      floatingActionButton: const AddButton(nextPage: ProductEditPage()),
    );
  }

  _buildBody() {
    return BlocBuilder<ProductPageBloc, ProductPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(ProductPageSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(ProductPageSupplements supp) {
    final items = supp.productList;
    if (items.isEmpty) {
      return const EmptyStateWidget(message: emptyItemsDesc);
    }

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ProductTile(item);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  static const emptyItemsDesc =
      'No Items have been added. Add one by clicking on the bottom-right corner button.';
}
