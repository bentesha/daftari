import '../source.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key, this.isFirstPage = false}) : super(key: key);

  final bool isFirstPage;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final CategoryPageBloc bloc;

  @override
  void initState() {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = CategoryPageBloc(categoriesService, itemsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.categories_page),
      appBar: widget.isFirstPage ? _buildAppBar2() : _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: const AddButton(nextPage: CategoryEditPage()),
      bottomNavigationBar: _buildBottomNavBar(),
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

    return AppTopBar(showDrawerCallback: _openDrawer, title: "Categories");
  }

  _buildAppBar2() {
    return AppBar(
      title: AppText('Categories',
          style: Theme.of(context).appBarTheme.titleTextStyle),
      automaticallyImplyLeading: false,
    );
  }

  _buildBody() {
    return BlocBuilder<CategoryPageBloc, CategoryPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(CategoryPageSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(CategoryPageSupplements supp) {
    final categories = supp.categoryList;
    if (categories.isEmpty) {
      return const EmptyStateWidget(
          decscription:
              'No categories found. Start creating categories by clicking on the bottom-right corner add button.');
    }

    return ListView.separated(
      separatorBuilder: (_, __) => Container(
        height: 1.5.dw,
        color: AppColors.divider,
      ),
      itemCount: categories.length,
      itemBuilder: (_, index) {
        final category = categories[index];
        final numberOfItems = supp.itemList
            .where((e) => e.categoryId == category.id)
            .toList()
            .length;

        return AppMaterialButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => CategoryPage(category))),
            padding: EdgeInsets.symmetric(vertical: 5.dh),
            isFilled: false,
            child: CategoryTile(
                title: category.name, numberOfItems: numberOfItems));
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  _buildBottomNavBar() {
    return BlocBuilder<CategoryPageBloc, CategoryPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: (_) => Container(height: .01),
              content: _buildGoToSalesPage,
              success: _buildGoToSalesPage);
        });
  }

  Widget _buildGoToSalesPage(CategoryPageSupplements supp) {
    if (supp.categoryList.isNotEmpty && supp.itemList.isNotEmpty) {
      return AppTextButton(
          height: 50.dh,
          width: double.infinity,
          textColor: AppColors.accent,
          backgroundColor: AppColors.secondary,
          text: 'Go to homepage',
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const SalesRecordsPage()),
              (route) => false));
    }
    return Container(height: .01);
  }
}
