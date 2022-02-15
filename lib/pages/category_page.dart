import '../source.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(this.category, {Key? key}) : super(key: key);

  final Category category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final ItemPageBloc bloc;

  @override
  void initState() {
    final service = Provider.of<ItemsService>(context, listen: false);
    bloc = ItemPageBloc(service);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: widget.category.name + ' Category',
        hasAction: true,
        actionIcon: Icons.edit_outlined,
        actionCallback: _navigateToCategoryEditPage,
      ),
      body: _buildBody(),
      floatingActionButton:
          AddButton(nextPage: ItemEditPage(categoryId: widget.category.id)),
    );
  }

  _navigateToCategoryEditPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CategoryEditPage(category: widget.category)));
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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ItemSupplements supp) {
    final items =
        supp.itemList.where((e) => e.categoryId == widget.category.id).toList();
    if (items.isEmpty) {
      return const EmptyStateWidget(
          decscription:
              'No items have been added in this category. Click on the add bottom right corner button to start creating items.');
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
}
