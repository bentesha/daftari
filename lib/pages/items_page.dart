import '../source.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: BlocBuilder<ItemPageBloc, ItemPageState>(
          bloc: bloc,
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                success: _buildContent);
          }),
      floatingActionButton: const AddButton(nextPage: ItemEditPage()),
    );
  }

  _buildAppBar() {
    final isScaffoldStateNull = _scaffoldKey.currentState == null;
    _openDrawer() {
      if (isScaffoldStateNull) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scaffoldKey.currentState!.openDrawer();
        });
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return AppTopBar(showDrawerCallback: _openDrawer, title: "Items List");
  }

  Widget _buildLoading(ItemSupplements supp) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(ItemSupplements supp) {
    final items = supp.itemList;

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
}
