import '../source.dart';

class ItemsSearchPage<T> extends StatefulWidget {
  const ItemsSearchPage({this.categoryType, this.documentType, Key? key})
      : super(key: key);

  final CategoryTypes? categoryType;
  final DocumentType? documentType;

  static Future<T?> navigateTo<T>(BuildContext context,
      {CategoryTypes? categoryType, DocumentType? documentType}) {
    return Navigator.of(context).push(MaterialPageRoute<T>(
        builder: (context) => ItemsSearchPage<T>(
            categoryType: categoryType, documentType: documentType)));
  }

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
    final salesService = getService<SalesService>(context);
    final expensesService = getService<ExpensesService>(context);
    bloc = SearchPageBloc<T>(
        productsService, categoriesService, salesService, expensesService);
    bloc.init(widget.categoryType, widget.documentType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageBloc<T>, SearchPageState<T>>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: _buildFailed,
          );
        });
  }

  Widget _buildLoading(SearchPageSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildContent(SearchPageSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildItems(supp),
    );
  }

  Widget _buildFailed(SearchPageSupplements supp, String? message) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(message ?? 'An error happened'),
          AppTextButton(
            onPressed: () => bloc.init(widget.categoryType),
            text: 'Try Again',
            height: 40.dh,
            backgroundColor: AppColors.primary,
            margin: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 10.dh),
          )
        ],
      )),
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
        T == CategoryTypes || T == WriteOffTypes
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
    dynamic categoryType = widget.categoryType;
    final type = T == Category
        ? '${categoryType.string.toLowerCase()} category'
        : 'product';
    final message = options.isEmpty && query.isEmpty
        ? 'No $type has been recorded yet. Create one by clicking on the add button on the page top bar'
        : 'No item matches your search keyword!';
    return EmptyStateWidget(message: message);
  }

  Widget _buildItemTile(var item) {
    return AppTextButton(
      onPressed: () {
        if (T == Document) {
          final document = item as Document;
          bloc.updateId(document.form.id);
        } else {
          bloc.updateId(item.id);
        }
        Navigator.pop(context, item);
        log('done');
      },
      child: ListTile(title: AppText(_getName(item), weight: FontWeight.w500)),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
    );
  }

  String _getName(var item) {
    if (T == Document) {
      return (item as Document).form.title;
    }
    return item.name;
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
    if (T == Product) nextPage = const ProductPage();
    if (T == Document) {
      if (widget.documentType == DocumentType.sales) {
        nextPage = const DocumentSalesPage(fromQuickActions: true);
      } else {
        nextPage = const DocumentExpensesPage(fromQuickActions: true);
      }
    }
    push(nextPage);
  }
}
