import '../source.dart';

mixin ServicesInitializer {
  void initServices(
      [ProductsService? productsService,
      RecordsService? recordsService,
      GroupsService? groupsService,
      CategoriesService? categoriesService]) {
    if (productsService != null) productsService.init();
    if (recordsService != null) recordsService.init();
    if (groupsService != null) groupsService.init();
    if (categoriesService != null) categoriesService.init();
  }
}
