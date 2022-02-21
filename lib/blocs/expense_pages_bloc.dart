import '../source.dart';

class ExpensePages extends Cubit<ExpensePagesState> {
  ExpensePages() : super(ExpensePagesState.initial());

  void init({Category? category}) {
    var supp = state.supplements;
    emit(ExpensePagesState.loading(supp));
  /*   initServices(productsService, null, null, categoriesService);
    final categories = categoriesService.getCategoryList;
    final products = productsService.getProductList;
    supp = supp.copyWith(categoryList: categories, productList: products);
    if (category != null) supp = supp.copyWith(category: category); */
    emit(ExpensePagesState.content(supp));
  }
}
