import '../source.dart';

class ItemSearchPage extends StatefulWidget {
  const ItemSearchPage({Key? key}) : super(key: key);

  @override
  State<ItemSearchPage> createState() => _ItemSearchPageState();
}

class _ItemSearchPageState extends State<ItemSearchPage> {
  late final ItemPageBloc bloc;
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = '';
    final service = Provider.of<ItemsService>(context, listen: false);
    bloc = ItemPageBloc(service);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemPageBloc, ItemPageState>(
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

  Widget _buildLoading(ItemSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ItemSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildItems(supp.itemList),
    );
  }

  _buildAppBar(ItemSupplements supp) {
    return AppBar(
      title: _buildTextField(supp),
    );
  }

  _buildItems(List<Item> itemList) {
    if (itemList.isEmpty) return _buildEmptyItemState();

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemCount: itemList.length,
      itemBuilder: (_, index) {
        return _buildItemTile(itemList[index]);
      },
    );
  }

  _buildEmptyItemState() {
    return const Center(
      child: AppText('No item matches your search keyword!'),
    );
  }

  Widget _buildItemTile(Item item) {
    return AppTextButton(
      onPressed: () => bloc.updateId(item.id),
      child: ListTile(title: AppText(item.title, weight: FontWeight.w500)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
    );
  }

  _buildTextField(ItemSupplements supp) {
    controller.text = supp.query;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));

    return Padding(
      padding: EdgeInsets.only(top: 3.dh),
      child: TextField(
        controller: controller,
        onChanged: bloc.updateSearchQuery,
        maxLines: 1,
        minLines: 1,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.dw,
          fontWeight: FontWeight.w100,
        ),
        cursorColor: AppColors.onPrimary,
        decoration: InputDecoration(
          suffixIcon: AppIconButton(
              icon: supp.query.isEmpty ? Icons.search : Icons.close,
              onPressed: supp.query.isEmpty ? () {} : bloc.clearQuery,
              iconThemeData: Theme.of(context).iconTheme.copyWith(size: 24.dw)),
          focusedBorder: border,
          enabledBorder: border,
          border: border,
          hintText: 'Search Items',
          hintStyle: TextStyle(
            color: AppColors.onPrimary,
            fontSize: 20.dw,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  final border = const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1.2, color: AppColors.primary));
}
