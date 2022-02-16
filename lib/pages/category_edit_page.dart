import '../source.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({Key? key, this.category}) : super(key: key);

  final Category? category;

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  late final CategoryPageBloc bloc;

  @override
  void initState() {
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = CategoryPageBloc(categoriesService, itemsService);
    bloc.init(category: widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: 'Add New Category',
        actionCallback: bloc.save,
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
        SizedBox(height: 15.dh),
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
}