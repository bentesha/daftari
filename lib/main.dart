import 'app.dart';
import 'source.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(appDirectory.path)
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(RecordAdapter())
    ..registerAdapter(GroupAdapter());

  await Hive.openBox(Constants.kItemsBox);
  await Hive.openBox(Constants.kRecordsBox);
  await Hive.openBox(Constants.kGroupsBox);

  final myApp = MultiProvider(
    providers: [
      ChangeNotifierProvider<ItemsService>(create: (_) => ItemsService()),
      ChangeNotifierProvider<GroupsService>(create: (_) => GroupsService()),
      ChangeNotifierProvider<RecordsService>(create: (_) => RecordsService()),
    ],
    child: const MyApp(),
  );

/*   await Hive.box(Constants.kGroupsBox).clear();
  await Hive.box(Constants.kRecordsBox).clear();
  await Hive.box(Constants.kItemsBox).clear();  */

  runApp(myApp);
}
