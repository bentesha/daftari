import '../source.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late final ItemPageBloc bloc;

  @override
  void initState() {
    final service = Provider.of<ItemsService>(context, listen: false);
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    bloc = ItemPageBloc(service, categoriesService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Items'),
      floatingActionButton: const AddButton(nextPage: ItemEditPage()),
    );
  }

  _buildBody() {
    return BlocBuilder<ItemPageBloc, ItemPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(ItemSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(ItemSupplements supp) {
    final items = supp.itemList;
    if (items.isEmpty) {
      return const EmptyStateWidget(message: emptyItemsDesc);
    }

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ItemTile(item);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  static const emptyItemsDesc =
      'No Items have been added. Add one by clicking on the bottom-right corner button.';
}
