import 'package:inventory_management/services/opening_stock_items_service.dart';
import 'app.dart';
import 'source.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive
    ..init(appDirectory.path)
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(ProductAdapter())
    ..registerAdapter(RecordAdapter())
    ..registerAdapter(ExpenseAdapter())
    ..registerAdapter(WriteOffAdapter())
    ..registerAdapter(OpeningStockItemAdapter())
    ..registerAdapter(GroupAdapter());

  await Hive.openBox(Constants.kProductsBox);
  await Hive.openBox(Constants.kRecordsBox);
  await Hive.openBox(Constants.kGroupsBox);
  await Hive.openBox(Constants.kCategoriesBox);
  await Hive.openBox(Constants.kExpenseBox);
  await Hive.openBox(Constants.kWriteOffsBox);
  await Hive.openBox(Constants.kOpeningStockItemsBox);

  final myApp = MultiProvider(
    providers: [
      ChangeNotifierProvider<ProductsService>(create: (_) => ProductsService()),
      ChangeNotifierProvider<GroupsService>(create: (_) => GroupsService()),
      ChangeNotifierProvider<RecordsService>(create: (_) => RecordsService()),
      ChangeNotifierProvider<TypeService>(create: (_) => TypeService()),
      ChangeNotifierProvider<WriteOffsTypesService>(
          create: (_) => WriteOffsTypesService()),
      ChangeNotifierProvider<WriteOffsService>(
          create: (_) => WriteOffsService()),
      ChangeNotifierProvider<ExpensesService>(create: (_) => ExpensesService()),
      ChangeNotifierProvider<OpeningStockItemsService>(
          create: (_) => OpeningStockItemsService()),
      ChangeNotifierProvider<CategoriesService>(
          create: (_) => CategoriesService()),
    ],
    child: const MyApp(),
  );

/*  await Hive.box(Constants.kGroupsBox).clear();
  await Hive.box(Constants.kRecordsBox).clear();
  await Hive.box(Constants.kProductsBox).clear();
  await Hive.box(Constants.kCategoriesBox).clear();
  await Hive.box(Constants.kOpeningStockItemsBox).clear();
  await Hive.box(Constants.kWriteOffsBox).clear();
  await Hive.box(Constants.kExpenseBox).clear(); */

  runApp(myApp);
}
