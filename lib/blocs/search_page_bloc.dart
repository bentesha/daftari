import '../source.dart';

class SearchPageBloc<T> extends Cubit<SearchPageState<T>>
    with ServicesInitializer {
  SearchPageBloc(this.productService, this.categoriesService, this.typeService)
      : super(SearchPageState<T>.initial()) {
    productService.addListener(() => _handleItemUpdates());
    categoriesService.addListener(() => _handleCategoryUpdates());
    categoriesService.addListener(() => _handleCategoryUpdates());
  }

  final ProductsService productService;
  final CategoriesService categoriesService;
  final TypeService typeService;

  var _options = [];

  void init() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    _initServices();
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
    if (T == Product) productService.updateId(id);
    if (T == Category) categoriesService.updateId(id);
    emit(SearchPageState.success(supp));
  }

  void updateType(CategoryType type) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    typeService.updateType(type);
    emit(SearchPageState.success(supp));
  }

  _handleItemUpdates() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final items = productService.getProductList.whereType<T>().toList();
    supp = supp.copyWith(options: items);
    emit(SearchPageState.content(supp));
  }

  _handleCategoryUpdates() {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final categories =
        categoriesService.getCategoryList.whereType<T>().toList();
    supp = supp.copyWith(options: categories);
    emit(SearchPageState.content(supp));
  }

  _initServices() {
    if (T == Product) initServices(productService);
    if (T == Category) initServices(null, null, null, categoriesService);
  }

  List _getOptions() {
    if (T == Product) return productService.getProductList;
    if (T == Category) return categoriesService.getCategoryList;
    if (T == CategoryType) return Constants.kCategoryTypesList;
    return [];
  }
}
