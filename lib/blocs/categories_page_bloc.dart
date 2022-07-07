import '../source.dart';

class CategoryPageBloc extends Cubit<CategoryPagesState> {
  CategoryPageBloc(this.categoriesService, this.productsService)
      : super(CategoryPagesState.initial()) {
    categoriesService.addListener(_handleCategoryUpdates);
    productsService.addListener(_handleProductUpdates);
  }

  CategoryPageBloc.empty()
      : categoriesService = CategoriesService(),
        productsService = ProductsService(),
        super(CategoryPagesState.initial());

  final CategoriesService categoriesService;
  final ProductsService productsService;

  void init(Pages page,
      {CategoryTypes? type, Category? category, PageActions? action}) async {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));

    final isSuccessful = await _initServices();
    if (!isSuccessful) return;
    _initCategoriesPage(page, type);
    _initCategoryPage(page, action, type, category);
  }

  void updateName(String name) => _updateAttributes(name: name);

  void updateDescription(String desc) => _updateAttributes(name: desc);

  void updateAction(PageActions action) => _updateAttributes(action: action);

  void updateType(CategoryTypes type) => _updateAttributes(categoryType: type);

  void save() async => await _commitChanges();

  void edit() async => await _commitChanges(false);

  void delete() async {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    try {
      await categoriesService.delete(supp.category.id);
      emit(CategoryPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  Future<void> _commitChanges([bool isSaving = true]) async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(CategoryPagesState.loading(supp));

    try {
      if (isSaving) await categoriesService.add(supp.category);
      if (!isSaving) await categoriesService.edit(supp.category);
      emit(CategoryPagesState.success(supp));
    } on ApiErrors catch (e) {
      _handleError(e);
    }
  }

  _validate() {
    var supp = state.supplements;
    final errors = <String, String?>{};

    emit(CategoryPagesState.loading(supp));
    errors['name'] = InputValidation.validateText(supp.category.name, 'Name');
    errors['type'] =
        InputValidation.validateText(supp.category.type.string, 'Type');

    supp = supp.copyWith(errors: errors);
    emit(CategoryPagesState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final categories = categoriesService.getList
        .where((e) => e.type == categoriesService.getCurrentType)
        .toList();
    supp = supp.copyWith(categoryList: categories);
    emit(CategoryPagesState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    final products = productsService.getList;
    supp = supp.copyWith(productList: products);
    emit(CategoryPagesState.content(supp));
  }

  _initCategoriesPage(Pages page, [CategoryTypes? type]) {
    if (page != Pages.categories_page) return;
    var supp = state.supplements;
    var categories = categoriesService.getList;

    if (type != null) {
      categories = categories.where((e) => e.type == type).toList();
    }

    final products = productsService.getList;
    supp = supp.copyWith(productList: products, categoryList: categories);
    emit(CategoryPagesState.content(supp));
  }

  _initCategoryPage(Pages page, PageActions? action,
      [CategoryTypes? type, Category? category]) {
    if (page != Pages.category_page) return;
    var supp = state.supplements;
    supp = supp.copyWith(action: action!);

    if (type != null) {
      CategoriesService.initType(type);
    }
    if (category != null) {
      CategoriesService.initType(category.type);
      supp = supp.copyWith(category: category);
    }

    emit(CategoryPagesState.content(supp));
  }

  void _updateAttributes(
      {String? name,
      String? description,
      PageActions? action,
      CategoryTypes? categoryType}) {
    var supp = state.supplements;
    emit(CategoryPagesState.loading(supp));
    var category = supp.category;
    category = category.copyWith(
        name: name ?? category.name,
        description: description,
        type: categoryType);
    supp = supp.copyWith(category: category, action: action ?? supp.action);
    emit(CategoryPagesState.content(supp));
  }

  Future<bool> _initServices() async {
    var isSuccessful = false;
    try {
      await categoriesService.init();
      await productsService.init();
      isSuccessful = true;
    } on ApiErrors catch (e) {
      emit(CategoryPagesState.failed(state.supplements,
          message: e.message, showOnPage: true));
    }
    return isSuccessful;
  }

  void _handleError(ApiErrors error) {
    emit(CategoryPagesState.failed(state.supplements, message: error.message));
  }
}
