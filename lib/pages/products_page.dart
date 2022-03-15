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
    _initBloc();
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
        listener: (_, state) {
          final error = state.maybeWhen(
              failed: (_, e, showOnPage) => showOnPage ? null : e,
              orElse: () => null);
          if (error != null) showSnackBar(error, context: context);
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(ProductPageSupplements supp) =>
      const AppLoadingIndicator();

  Widget _buildFailed(
      ProductPageSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(message!),
        AppTextButton(
            onPressed: _initBloc,
            text: 'Try Again',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            margin: EdgeInsets.only(top: 10.dh))
      ],
    ));
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

  _buildFloatingButton() {
    return BlocBuilder<ProductPageBloc, ProductPageState>(
        bloc: bloc,
        builder: (_, state) {
          final isLoading =
              state.maybeWhen(loading: (_) => true, orElse: () => false);
          if (isLoading) return Container();
          return const AddButton(nextPage: ProductPage());
        });
  }

  _initBloc() {
    final productsService = getService<ProductsService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final openingStockItemsService =
        getService<OpeningStockItemsService>(context);
    bloc = ProductPageBloc(
        productsService, categoriesService, openingStockItemsService);
    bloc.init(Pages.products_page);
  }

  static const emptyItemsDesc =
      'No products have been added. Add one by clicking on the bottom-right corner button.';
}
