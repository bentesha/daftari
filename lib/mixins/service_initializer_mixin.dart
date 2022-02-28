import 'package:inventory_management/services/opening_stock_items_service.dart';

import '../source.dart';

mixin ServicesInitializer {
  void initServices(
      {ProductsService? productsService,
      RecordsService? recordsService,
      WriteOffsService? writeOffService,
      GroupsService? groupsService,
      OpeningStockItemsService? openingStockItemsService,
      ExpensesService? expensesService,
      CategoriesService? categoriesService}) {
    if (productsService != null) productsService.init();
    if (recordsService != null) recordsService.init();
    if (openingStockItemsService != null) openingStockItemsService.init();
    if (groupsService != null) groupsService.init();
    if (categoriesService != null) categoriesService.init();
    if (expensesService != null) expensesService.init();
    if (writeOffService != null) writeOffService.init();
  }
}
