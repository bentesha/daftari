import '../source.dart';

mixin ServicesInitializer {
  Future<void> initServices(
      {ProductsService? productsService,
      WriteOffsService? writeOffService,
      SalesService? salesService,
      PurchasesService? purchasesService,
      OpeningStockItemsService? openingStockItemsService,
      ExpensesService? expensesService,
      CategoriesService? categoriesService}) async {
    if (productsService != null) await productsService.init();
    if (openingStockItemsService != null) openingStockItemsService.init();
    if (salesService != null) await salesService.init();
    if (purchasesService != null) await purchasesService.init();
    if (categoriesService != null) await categoriesService.init();
    if (expensesService != null) expensesService.init();
    if (writeOffService != null) writeOffService.init();
  }
}
