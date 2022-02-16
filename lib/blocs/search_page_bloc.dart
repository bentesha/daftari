import '../source.dart';

class SearchPageBloc<T> extends Cubit<SearchPageState<T>> {
  SearchPageBloc(this.itemsService, this.categoryService)
      : super(SearchPageState<T>.initial());

  final ItemsService itemsService;
  final CategoriesService categoryService;

  final _options = [];

  void init(List<T> options) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    supp = supp.copyWith(options: options);
    emit(SearchPageState.content(supp));
  }

  void updateSearchQuery(String query) {
    var supp = state.supplements;
    emit(SearchPageState.loading(supp));
    final list = _options
        .where((e) => e.title.toLowerCase().startsWith(query.toLowerCase()))
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
    if (T == Item) itemsService.updateId(id);
    if (T == Category) categoryService.updateId(id);
    emit(SearchPageState.success(supp));
  }
}
