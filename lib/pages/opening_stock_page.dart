import 'package:inventory_management/widgets/opening_stock_item_tile.dart';

import '../services/opening_stock_items_service.dart';
import '../source.dart';

class OpeningStockPage extends StatefulWidget {
  const OpeningStockPage({Key? key}) : super(key: key);

  @override
  State<OpeningStockPage> createState() => _OpeningStockPageState();
}

class _OpeningStockPageState extends State<OpeningStockPage> {
  late final OpeningStockPagesBloc bloc;

  @override
  void initState() {
    final productsService = getService<ProductsService>(context);
    final itemsService = getService<OpeningStockItemsService>(context);
    bloc = OpeningStockPagesBloc(itemsService, productsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Opening Stock'),
      body: _buildBody(),
      floatingActionButton: const AddButton(nextPage: OpeningStockEditPage()),
    );
  }

  _buildBody() {
    return BlocBuilder<OpeningStockPagesBloc, OpeningStockPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(OpeningStockSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
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
        return OpeningStockItemTile(item);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  static const emptyItemsMessage =
      'No items have been added. Click on the add bottom right corner button to start creating items.';
}
