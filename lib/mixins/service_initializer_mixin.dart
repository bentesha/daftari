import '../source.dart';

mixin ServicesInitializer {
  Future<void> initServices(
      {ProductsService? productsService,
      WriteOffsService? writeOffService,
      SalesService? salesService,
      OpeningStockItemsService? openingStockItemsService,
      ExpensesService? expensesService,
      CategoriesService? categoriesService}) async {
    if (productsService != null) productsService.init();
    if (openingStockItemsService != null) openingStockItemsService.init();
    if (salesService != null) salesService.init();
    if (categoriesService != null) await categoriesService.init();
    if (expensesService != null) expensesService.init();
    if (writeOffService != null) writeOffService.init();
  }
}
