import '../source.dart';

class SearchPageBloc<T> extends Cubit<SearchPageState<T>> {
  SearchPageBloc(this.productsService, this.categoriesService,
      this.categoryTypesService, this.writeOffTypesService)
      : super(SearchPageState<T>.initial()) {
    productsService.addListener(_handleItemUpdates);
    categoriesService.addListener(_handleCategoryUpdates);
  }

  final ProductsService productsService;
  final CategoriesService categoriesService;
  final CategoryTypesService categoryTypesService;
  final WriteOffsTypesService writeOffTypesService;

  var _options = [];
  var _categoryType = '';

  void init([CategoryType? categoryType]) async {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (categoryType != null) _categoryType = categoryType.name;
    await _initServices();
    _options = _getOptions();
    final options = _options.whereType<T>().toList();
    supp = supp.copyWith(options: options);
    emit(SearchPageState.content(supp));
  }

  void updateSearchQuery(String query) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final list = _options
        .where((e) => e.name.toLowerCase().startsWith(query.toLowerCase()))
        .whereType<T>()
        .toList();
    supp = supp.copyWith(options: list, query: query);
    emit(SearchPageState.content(supp));
  }

  void clearQuery() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final list = _options.whereType<T>().toList();
    supp = supp.copyWith(options: list, query: '');
    emit(SearchPageState.content(supp));
  }

  void updateId(String id) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (T == Product) productsService.updateCurrent(id);
    if (T == Category) categoriesService.updateCurrent(id);
    emit(SearchPageState.success(supp));
  }

  void updateType(CategoryType type) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    categoryTypesService.updateType(type);
    emit(SearchPageState.success(supp));
  }

  void updateWriteOffType(WriteOffType writeOffType) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    writeOffTypesService.updateType(writeOffType);
    emit(SearchPageState.success(supp));
  }

  _handleItemUpdates() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final items = productsService.getList.whereType<T>().toList();
    supp = supp.copyWith(options: items);
    emit(SearchPageState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    var categories = categoriesService.getList;
    categories = categories.where((e) => e.type == _categoryType).toList();
    final options = categories.whereType<T>().toList();
    supp = supp.copyWith(options: options);
    emit(SearchPageState.content(supp));
  }

  //TODO to this point it is services are already initiated. This could be removed.
  Future<void> _initServices() async {
    if (T == Product) await productsService.init();
    if (T == Category) {
      if (_categoryType == CategoryType.products().name) {
        await categoriesService.init();
      }
    }
  }

  List _getOptions() {
    if (T == Product) return productsService.getList;
    if (T == CategoryType) return categoryTypesService.getTypeList;
    if (T == WriteOffType) return writeOffTypesService.getTypeList;
    if (T == Category) {
      final categories = categoriesService.getList;
      return categories.where((e) => e.type == _categoryType).toList();
    }

    return [];
  }
}
