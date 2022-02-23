import '../source.dart';

class CategoryPageBloc extends Cubit<CategoryPagesState>
    with ServicesInitializer {
  CategoryPageBloc(
      this.categoriesService, this.productsService, this.typeService)
      : super(CategoryPagesState.initial()) {
    categoriesService.addListener(() => _handleCategoryUpdates());
    productsService.addListener(() => _handleItemUpdates());
    typeService.addListener(() => _handleTypeUpdates());
  }

  final CategoriesService categoriesService;
  final ProductsService productsService;
  final TypeService typeService;

  void init({Category? category}) {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    initServices(
        productsService: productsService, categoriesService: categoriesService);
    final categories = categoriesService.getList;
    final products = productsService.getList;
    supp = supp.copyWith(categoryList: categories, productList: products);
    if (category != null) supp = supp.copyWith(category: category);
    emit(CategoryPagesState.content(supp));
  }

  void updateName(String name) => _updateAttributes(name: name);
  void updateDescription(String desc) => _updateAttributes(name: desc);

  void _updateAttributes({String? name, String? description}) {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final category =
        supp.category.copyWith(name: name, description: description);
    supp = supp.copyWith(category: category);
    emit(CategoryPagesState.content(supp));
  }

  void save() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(CategoryPagesState.loading(supp));
    final category = supp.category.copyWith(id: Utils.getRandomId());
    await categoriesService.addCategory(category);
    emit(CategoryPagesState.success(supp));
  }

  void edit() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(CategoryPagesState.loading(supp));
    await categoriesService.editCategory(supp.category);
    emit(CategoryPagesState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(CategoryPagesState.loading(supp));
    errors['name'] = InputValidation.validateText(supp.category.name, 'Name');
    errors['type'] =
        InputValidation.validateText(supp.category.type ?? '', 'Type');

    supp = supp.copyWith(errors: errors);
    emit(CategoryPagesState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final categories = categoriesService.getList;
    supp = supp.copyWith(categoryList: categories);
    emit(CategoryPagesState.content(supp));
  }

  _handleItemUpdates() {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final products = productsService.getList;
    supp = supp.copyWith(productList: products);
    emit(CategoryPagesState.content(supp));
  }

  _handleTypeUpdates() {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final type = typeService.getSelectedType;
    final category = supp.category.copyWith(type: type.name);
    supp = supp.copyWith(category: category);
    emit(CategoryPagesState.content(supp));
  }
}
