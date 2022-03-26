import '../source.dart';
import '../widgets/type_selector.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({Key? key, this.category, this.categoryType})
      : super(key: key);

  final Category? category;
  final CategoryTypes? categoryType;

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  var bloc = CategoryPageBloc.empty();
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

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(CategoryPageSupplements supp) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(supp),
      body: _buildBody(supp),
    );
  }

  _buildAppBar(CategoryPageSupplements supp) {
    final action = supp.action;
    return PageAppBar(
      title: action.isViewing
          ? supp.category.name
          : action.isAdding
              ? 'New Category'
              : 'Edit Category',
      actionCallbacks: action.isViewing
          ? [() => bloc.updateAction(PageActions.editing), bloc.delete]
          : [action.isEditing ? bloc.edit : bloc.save],
      actionIcons: action.isViewing
          ? [Icons.edit_outlined, Icons.delete_outlined]
          : [Icons.check],
    );
  }

  Widget _buildBody(CategoryPageSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        //when obtained when making a new category from the search page
        widget.categoryType != null
            ? Container()
            : TypeSelector<CategoryTypes>(
                title: 'Type',
                selectedType: supp.category.type,
                error: supp.errors['type'],
                isEditable: !action.isViewing,
                onTypeSelected: bloc.updateType),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        !action.isViewing
            ? AppTextField(
                text: supp.category.name,
                onChanged: bloc.updateName,
                hintText: '',
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                label: 'Name',
                error: supp.errors['name'],
                isEnabled: !action.isViewing)
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
            isEnabled: !action.isViewing),
      ],
    );
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final categoriesService = getService<CategoriesService>(context);
      final itemsService = getService<ProductsService>(context);
      bloc = CategoryPageBloc(categoriesService, itemsService);
    }
    final action =
        widget.category == null ? PageActions.adding : PageActions.viewing;
    bloc.init(Pages.category_page,
        type: widget.categoryType, category: widget.category, action: action);
  }

  _tryInitAgain() => _initBloc(false);
}
