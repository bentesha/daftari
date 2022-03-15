import '../source.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({Key? key, this.category, this.categoryType})
      : super(key: key);

  final Category? category;
  final CategoryType? categoryType;

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  late final CategoryPageBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryPageBloc, CategoryPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccess =
              state.maybeWhen(success: (_) => true, orElse: () => false);
          if (isSuccess) pop();

          final error = state.maybeWhen(
              failed: (_, e, showOnPage) => showOnPage ? null : e,
              orElse: () => null);
          if (error != null) showSnackBar(error, scaffoldKey: _scaffoldKey);
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(CategoryPageSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      CategoryPageSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(message!),
        AppTextButton(
            onPressed: _initBloc,
            text: 'Try Again',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            margin: EdgeInsets.only(top: 10.dh))
      ],
    ));
  }

  Widget _buildContent(CategoryPageSupplements supp) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(supp),
      body: _buildBody(supp),
    );
  }

  _buildAppBar(CategoryPageSupplements supp) {
    return PageAppBar(
      title: supp.isViewing
          ? supp.category.name
          : supp.isAdding
              ? 'New Category'
              : 'Edit Category',
      actionCallbacks: supp.isViewing
          ? [() => bloc.updateAction(PageActions.editing), bloc.delete]
          : [supp.isEditing ? bloc.edit : bloc.save],
      actionIcons: supp.isViewing
          ? [Icons.edit_outlined, Icons.delete_outlined]
          : [Icons.check],
    );
  }

  Widget _buildBody(CategoryPageSupplements supp) {
    return Column(
      children: [
        //when obtained when making a new category from the search page
        widget.categoryType != null
            ? Container()
            : ValueSelector(
                title: 'Type',
                value: supp.category.type,
                error: supp.errors['type'],
                isEditable: !supp.isViewing,
                onPressed: () => push(ItemsSearchPage<CategoryType>(
                    categoryType: widget.categoryType)),
              ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        !supp.isViewing
            ? AppTextField(
                text: supp.category.name,
                onChanged: bloc.updateName,
                hintText: '',
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                label: 'Name',
                error: supp.errors['name'],
                isEnabled: !supp.isViewing)
            : Container(),
        AppTextField(
            error: supp.errors['description'],
            text: supp.category.description,
            onChanged: bloc.updateDescription,
            hintText: '',
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            label: 'Description',
            maxLines: 3,
            isEnabled: !supp.isViewing),
      ],
    );
  }

  _initBloc() {
    final categoriesService = getService<CategoriesService>(context);
    final itemsService = getService<ProductsService>(context);
    final typeService = getService<CategoryTypesService>(context);
    bloc = CategoryPageBloc(categoriesService, itemsService, typeService);
    final action =
        widget.category == null ? PageActions.adding : PageActions.viewing;
    bloc.init(Pages.category_page,
        type: widget.categoryType, category: widget.category, action: action);
  }
}
