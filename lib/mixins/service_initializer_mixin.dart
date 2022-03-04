import '../source.dart';

mixin ServicesInitializer {
  Future<void> initServices(
      {ProductsService? productsService,
      RecordsService? recordsService,
      WriteOffsService? writeOffService,
      GroupsService? groupsService,
      OpeningStockItemsService? openingStockItemsService,
      ExpensesService? expensesService,
      CategoriesService? categoriesService}) async {
    if (productsService != null) productsService.init();
    if (recordsService != null) recordsService.init();
    if (openingStockItemsService != null) openingStockItemsService.init();
    if (groupsService != null) groupsService.init();
    if (categoriesService != null) await categoriesService.init();
    if (expensesService != null) expensesService.init();
    if (writeOffService != null) writeOffService.init();
  }
}
