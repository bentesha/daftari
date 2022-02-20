import '../source.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final CategoryPageBloc bloc;

  @override
  void initState() {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    final itemsService = Provider.of<ProductsService>(context, listen: false);
    bloc = CategoryPageBloc(categoriesService, itemsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Categories'),
      body: _buildBody(),
      floatingActionButton: const AddButton(nextPage: CategoryEditPage()),
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
      return const EmptyStateWidget(message: emptyCategoriesMessage);
    }

    return ListView.separated(
      separatorBuilder: (_, __) => Container(
        height: 1.5.dw,
        color: AppColors.divider,
      ),
      itemCount: categories.length,
      itemBuilder: (_, index) {
        final category = categories[index];
        final numberOfItems = supp.productList
            .where((e) => e.categoryId == category.id)
            .toList()
            .length;

        return CategoryTile(category: category, numberOfItems: numberOfItems);
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  static const emptyCategoriesMessage =
      'No categories found. Start creating categories by clicking on the bottom-right corner add button.';
}
