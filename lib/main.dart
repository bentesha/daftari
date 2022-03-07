import 'app.dart';
import 'source.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive
    ..init(appDirectory.path)
    ..registerAdapter(RecordAdapter())
    ..registerAdapter(ExpenseAdapter())
    ..registerAdapter(WriteOffAdapter())
    ..registerAdapter(OpeningStockItemAdapter())
    ..registerAdapter(GroupAdapter());

  await Hive.openBox(Constants.kRecordsBox);
  await Hive.openBox(Constants.kGroupsBox);
  await Hive.openBox(Constants.kExpenseBox);
  await Hive.openBox(Constants.kWriteOffsBox);
  await Hive.openBox(Constants.kOpeningStockItemsBox);

  final myApp = MultiProvider(
    providers: [
      _createProvider<ProductsService>(ProductsService()),
      _createProvider<GroupsService>(GroupsService()),
      _createProvider<RecordsService>(RecordsService()),
      _createProvider<CategoriesService>(CategoriesService()),
      _createProvider<CategoryTypesService>(CategoryTypesService()),
      _createProvider<WriteOffsService>(WriteOffsService()),
      _createProvider<WriteOffsTypesService>(WriteOffsTypesService()),
      _createProvider<ExpensesService>(ExpensesService()),
      _createProvider<OpeningStockItemsService>(OpeningStockItemsService()),
    ],
    child: const MyApp(),
  );
/* 
  await Hive.box(Constants.kGroupsBox).clear();
  await Hive.box(Constants.kRecordsBox).clear();
  await Hive.box(Constants.kProductsBox).clear();
  await Hive.box(Constants.kCategoriesBox).clear();
  await Hive.box(Constants.kOpeningStockItemsBox).clear();
  await Hive.box(Constants.kWriteOffsBox).clear();
  await Hive.box(Constants.kExpenseBox).clear(); */

  runApp(myApp);
}

_createProvider<T extends ChangeNotifier>(var service) =>
    ChangeNotifierProvider<T>(create: (_) => service);
