import '../source.dart';

class SearchPageBloc<T> extends Cubit<SearchPageState<T>> {
  SearchPageBloc(this.productsService, this.categoriesService)
      : super(SearchPageState<T>.initial()) {
    productsService.addListener(_handleItemUpdates);
    categoriesService.addListener(_handleCategoryUpdates);
  }

  final ProductsService productsService;
  final CategoriesService categoriesService;

  var _options = [];
  var _categoryType = CategoryTypes.expenses;

  void init([CategoryTypes? categoryType]) async {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (categoryType != null) _categoryType = categoryType;
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

  //* to this point these services are already initiated. This could be removed.
  Future<void> _initServices() async {
    if (T == Product) await productsService.init();
    if (T == Category) {
      if (_categoryType == CategoryTypes.products) {
        await categoriesService.init();
      }
    }
  }

  List _getOptions() {
    if (T == Product) return productsService.getList;
    if (T == Category) {
      final categories = categoriesService.getList;
      return categories.where((e) => e.type == _categoryType).toList();
    }

    return [];
  }
}
