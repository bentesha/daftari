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
    ..registerAdapter(GroupAdapter());

  await Hive.openBox(Constants.kProductsBox);
  await Hive.openBox(Constants.kRecordsBox);
  await Hive.openBox(Constants.kGroupsBox);
  await Hive.openBox(Constants.kCategoriesBox);

  final myApp = MultiProvider(
    providers: [
      ChangeNotifierProvider<ProductsService>(create: (_) => ProductsService()),
      ChangeNotifierProvider<GroupsService>(create: (_) => GroupsService()),
      ChangeNotifierProvider<RecordsService>(create: (_) => RecordsService()),
      ChangeNotifierProvider<CategoriesService>(
          create: (_) => CategoriesService()),
    ],
    child: const MyApp(),
  );

  await Hive.box(Constants.kGroupsBox).clear();
  await Hive.box(Constants.kRecordsBox).clear();
  await Hive.box(Constants.kProductsBox).clear();
  await Hive.box(Constants.kCategoriesBox).clear();

  runApp(myApp);
}
