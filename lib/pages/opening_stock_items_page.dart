import 'package:inventory_management/widgets/opening_stock_item_tile.dart';
import '../source.dart';

class OpeningStockItemsPage extends StatefulWidget {
  const OpeningStockItemsPage({Key? key}) : super(key: key);

  @override
  State<OpeningStockItemsPage> createState() => _OpeningStockItemsPageState();
}

class _OpeningStockItemsPageState extends State<OpeningStockItemsPage> {
  var bloc = OpeningStockPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Opening Stock Items'),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  _buildBody() {
    return BlocBuilder<OpeningStockPagesBloc, OpeningStockPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(OpeningStockSupplements supp) =>
      const AppLoadingIndicator();

  Widget _buildFailed(
      OpeningStockSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(OpeningStockSupplements supp) {
    final items = supp.openingStockItems;
    if (items.isEmpty) {
      return const EmptyStateWidget(message: emptyItemsMessage);
    }

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final product = bloc.getProductById(item.productId);
        return OpeningStockItemTile(item, product: product!);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<OpeningStockPagesBloc, OpeningStockPagesState>(
        bloc: bloc,
        builder: (_, state) {
          final shouldShowButton = state.maybeWhen(
              content: (_) => true,
              failed: (_, __, showOnPage) => !showOnPage,
              orElse: () => false);
          if (!shouldShowButton) return Container();
          return const AddButton(nextPage: OpeningStockItemPage());
        });
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final productsService = getService<ProductsService>(context);
      final itemsService = getService<OpeningStockItemsService>(context);
      bloc = OpeningStockPagesBloc(itemsService, productsService);
    }
    bloc.init(Pages.opening_stock_items_page);
  }

  _tryInitAgain() => _initBloc(false);

  static const emptyItemsMessage =
      'No items have been added. Click on the add bottom right corner button to start creating items.';
}
