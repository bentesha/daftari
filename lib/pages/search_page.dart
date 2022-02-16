import '../source.dart';

class ItemsSearchPage<T> extends StatefulWidget {
  const ItemsSearchPage(this.options, {Key? key}) : super(key: key);

  final List<T> options;

  @override
  State<ItemsSearchPage<T>> createState() => _ItemsSearchPageState();
}

class _ItemsSearchPageState<T> extends State<ItemsSearchPage<T>> {
  late final SearchPageBloc<T> bloc;
  final controller = TextEditingController();

  @override
  void initState() {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = SearchPageBloc(itemsService, categoriesService);
    bloc.init(widget.options);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchPageBloc<T>, SearchPageState<T>>(
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

  Widget _buildLoading(SearchPageSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(SearchPageSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildItems(),
    );
  }

  _buildAppBar(SearchPageSupplements supp) {
    return AppBar(
      title: _buildTextField(supp),
    );
  }

  _buildItems() {
    final itemList = widget.options;
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

  Widget _buildItemTile(var item) {
    return AppTextButton(
      onPressed: () => bloc.updateId(item.id),
      child: ListTile(title: AppText(item.name, weight: FontWeight.w500)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
    );
  }

  _buildTextField(SearchPageSupplements supp) {
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
          hintText: 'Search',
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
