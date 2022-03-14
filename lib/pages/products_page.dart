import '../source.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductPageBloc bloc;

  @override
  void initState() {
    final productsService = getService<ProductsService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final openingStockItemsService =
        getService<OpeningStockItemsService>(context);
    bloc = ProductPageBloc(
        productsService, categoriesService, openingStockItemsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Products'),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  _buildBody() {
    return BlocConsumer<ProductPageBloc, ProductPageState>(
        bloc: bloc,
        listener: (_, state) {},
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  Widget _buildLoading(ProductPageSupplements supp) =>
      const AppLoadingIndicator();

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

  _buildFloatingButton() {
    return BlocBuilder<ProductPageBloc, ProductPageState>(
        bloc: bloc,
        builder: (_, state) {
          final isLoading =
              state.maybeWhen(loading: (_) => true, orElse: () => false);
          if (isLoading) return Container();
          return const AddButton(nextPage: ProductEditPage());
        });
  }

  static const emptyItemsDesc =
      'No products have been added. Add one by clicking on the bottom-right corner button.';
}
