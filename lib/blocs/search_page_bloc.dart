import '../source.dart';

class SearchPageBloc<T> extends Cubit<SearchPageState<T>> {
  SearchPageBloc(this.productsService, this.categoriesService,
      this.salesService, this.expensesService)
      : super(SearchPageState<T>.initial()) {
    productsService.addListener(_handleItemUpdates);
    categoriesService.addListener(_handleCategoryUpdates);
    salesService.addListener(() => handleDocumentUpdates(DocumentType.sales));
    expensesService
        .addListener(() => handleDocumentUpdates(DocumentType.expenses));
  }

  final ProductsService productsService;
  final CategoriesService categoriesService;
  final SalesService salesService;
  final ExpensesService expensesService;

  var _options = [];
  var _categoryType = CategoryTypes.expenses;
  var _documentType = DocumentType.sales;

  /// uses specific item services to initiate options
  void init([CategoryTypes? categoryType, DocumentType? documentType]) async {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (categoryType != null) _categoryType = categoryType;
    if (documentType != null) _documentType = documentType;
    await _initServices();

    final hasFailed = state.maybeWhen(
        failed: (_, error) => error != null, orElse: () => false);
    if (hasFailed) return;
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

  void updateCurrent(var item) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    if (T == Product) productsService.updateCurrent(item.id);
    if (T == Category) categoriesService.updateCurrent(item.id);
    if (T == Document) {
      if (_documentType == DocumentType.sales) salesService.updateCurrent(item);
      if (_documentType == DocumentType.expenses) {
        expensesService.updateCurrent(item);
      }
    }
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

  void handleDocumentUpdates(DocumentType type) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    var documents = type == DocumentType.sales
        ? salesService.getList
        : expensesService.getList;
    final options = documents.whereType<T>().toList();
    final tempOptions = type.isSales
        ? salesService.getTemporaryDocList
        : expensesService.getTemporaryDocList;
    options.addAll(tempOptions.whereType<T>());
    supp = supp.copyWith(options: options);
    emit(SearchPageState.content(supp));
  }

  Future<void> _initServices() async {
    try {
      if (T == Product) await productsService.init();
      if (T == Document) {
        if (_documentType == DocumentType.sales) await salesService.init();
        if (_documentType == DocumentType.expenses) {
          await expensesService.init();
        }
      }
      if (T == Category) {
        if (_categoryType == CategoryTypes.products) {
          await categoriesService.init();
        }
      }
    } on ApiErrors catch (error) {
      emit(SearchPageState.failed(state.supplements, error.message));
    }
  }

  List _getOptions() {
    if (T == Product) return productsService.getList;
    if (T == Document) {
      if (_documentType == DocumentType.sales) return salesService.getList;
      if (_documentType == DocumentType.expenses) {
        return expensesService.getList;
      }
    }
    if (T == Category) {
      final categories = categoriesService.getList;
      return categories.where((e) => e.type == _categoryType).toList();
    }

    return [];
  }
}
