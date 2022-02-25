import '../source.dart';

class ItemsSearchPage<T> extends StatefulWidget {
  const ItemsSearchPage({required this.categoryType, Key? key})
      : super(key: key);

  final CategoryType? categoryType;

  @override
  State<ItemsSearchPage<T>> createState() => _ItemsSearchPageState();
}

class _ItemsSearchPageState<T> extends State<ItemsSearchPage<T>> {
  late final SearchPageBloc<T> bloc;
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    final productsService = getService<ProductsService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final typeService = getService<TypeService>(context);
    bloc = SearchPageBloc(productsService, categoriesService, typeService);
    bloc.init(widget.categoryType);
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildContent(SearchPageSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildItems(supp),
    );
  }

  _buildAppBar(SearchPageSupplements supp) {
    final iconThemeData = Theme.of(context).iconTheme;
    return AppBar(
      title: _buildTextField(supp),
      actions: [
        AppIconButton(
            icon: supp.query.isEmpty ? Icons.search : Icons.close,
            onPressed: supp.query.isEmpty
                ? () => focusNode.requestFocus()
                : bloc.clearQuery,
            iconThemeData: iconThemeData.copyWith(size: 24.dw)),
        T == CategoryType
            ? SizedBox(width: 15.dw)
            : AppIconButton(
                onPressed: _navigateToSpecificTypeWidget,
                icon: Icons.add,
                margin: EdgeInsets.only(right: 15.dw, left: 15.dw),
                iconThemeData: iconThemeData.copyWith(size: 30.dw))
      ],
    );
  }

  _buildItems(SearchPageSupplements supp) {
    final itemList = supp.options.whereType<T>().toList();
    if (itemList.isEmpty) return _buildEmptyItemState(itemList, supp.query);

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemCount: itemList.length,
      itemBuilder: (_, index) {
        return _buildItemTile(itemList[index]);
      },
    );
  }

  _buildEmptyItemState(List<T> options, String query) {
    final type = T == Category
        ? widget.categoryType!.name == CategoryType.expenses().name
            ? 'expense category'
            : 'product category'
        : 'product';
    final message = options.isEmpty && query.isEmpty
        ? 'No $type has been recorded yet. Create one by clicking on the add button on the page top bar'
        : 'No item matches your search keyword!';
    return EmptyStateWidget(message: message);
  }

  Widget _buildItemTile(var item) {
    return AppTextButton(
      onPressed: () =>
          T == CategoryType ? bloc.updateType(item) : bloc.updateId(item.id),
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
        focusNode: focusNode,
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

  _navigateToSpecificTypeWidget() {
    late Widget nextPage;

    if (T == Category) {
      nextPage = CategoryEditPage(categoryType: widget.categoryType);
    }
    if (T == Product) nextPage = const ProductEditPage();
    Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));
  }
}
