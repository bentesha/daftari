import '../source.dart';

typedef ExpenseCategory = Category;
typedef ProductsCategory = Category;

class SearchPageBloc<T> extends Cubit<SearchPageState<T>>
    with ServicesInitializer {
  SearchPageBloc(this.productsService, this.categoriesService, this.typeService,
      this.writeOffTypesService)
      : super(SearchPageState<T>.initial()) {
    productsService.addListener(() => _handleItemUpdates());
    categoriesService.addListener(() => _handleCategoryUpdates());
  }

  final ProductsService productsService;
  final CategoriesService categoriesService;
  final TypeService typeService;
  final WriteOffsTypesService writeOffTypesService;

  var _options = [];
  var _categoryType = '';

  void init([CategoryType? categoryType]) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (categoryType != null) _categoryType = categoryType.name;
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
    if (T == Product) productsService.updateId(id);
    if (T == Category) categoriesService.updateId(id);
    emit(SearchPageState.success(supp));
  }

  void updateType(CategoryType type) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    typeService.updateType(type);
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

  _initServices() {
    if (T == Product) initServices(productsService: productsService);
    if (T == Category) {
      if (_categoryType == CategoryType.products().name) {
        initServices(categoriesService: categoriesService);
      }
    }
  }

  List _getOptions() {
    if (T == Product) return productsService.getList;
    if (T == CategoryType) return typeService.getCategoryTypeList;
    if (T == WriteOffType) return writeOffTypesService.getWriteOffTypesList;
    if (T == Category) {
      final categories = categoriesService.getList;
      return categories.where((e) => e.type == _categoryType).toList();
    }

    return [];
  }
}
