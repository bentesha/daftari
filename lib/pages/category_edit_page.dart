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
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.category != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: '${!isEditing ? 'New' : 'Edit'} Category',
        actionCallbacks: [isEditing ? bloc.edit : bloc.save],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<CategoryPageBloc, CategoryPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccess =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccess) Navigator.pop(context);
        },
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
    return Column(
      children: [
        widget.categoryType != null
            ? Container()
            : ValueSelector(
                title: 'Type',
                value: supp.category.type,
                error: supp.errors['type'],
                isEditable: !isEditing,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ItemsSearchPage<CategoryType>(
                            categoryType: widget.categoryType))),
              ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            text: supp.category.name,
            onChanged: bloc.updateName,
            hintText: '',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'Name',
            error: supp.errors['name']),
        AppTextField(
          error: supp.errors['description'],
          text: supp.category.description,
          onChanged: bloc.updateDescription,
          hintText: '',
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          label: 'Description',
          maxLines: 3,
        ),
      ],
    );
  }

  _initBloc() {
    final categoriesService = getService<CategoriesService>(context);
    final itemsService = getService<ProductsService>(context);
    final typeService = getService<TypeService>(context);
    bloc = CategoryPageBloc(categoriesService, itemsService, typeService);
    bloc.init(widget.categoryType, widget.category);
  }
}
