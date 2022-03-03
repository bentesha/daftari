import '../source.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(this.category, {Key? key}) : super(key: key);

  final Category category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
      appBar: PageAppBar(
        title: widget.category.name + ' Category',
        actionIcons: const [Icons.edit_outlined],
        actionCallbacks: [_navigateToCategoryEditPage],
      ),
      body: _buildBody(),
      floatingActionButton:
          AddButton(nextPage: ProductEditPage(categoryId: widget.category.id)),
    );
  }

  _navigateToCategoryEditPage() =>
      push(CategoryEditPage(category: widget.category));

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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ProductPageSupplements supp) {
    final items = supp.productList
        .where((e) => e.categoryId == widget.category.id)
        .toList();
    if (items.isEmpty) {
      return const EmptyStateWidget(message: emptyItemsMessage);
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

  static const emptyItemsMessage =
      'No items have been added in this category. Click on the add bottom right corner button to start creating items.';
}
