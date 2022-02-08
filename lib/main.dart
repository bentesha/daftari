import 'app.dart';
import 'source.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(appDirectory.path)
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(RecordAdapter());

  await Hive.openBox(Constants.kItemsBox);
  await Hive.openBox(Constants.kRecordsBox);

  final myApp = MultiProvider(
    providers: [
      Provider<RecordsPageBloc>(
          create: (_) => RecordsPageBloc(RecordsService(), ItemsService()))
    ],
    child: const MyApp(),
  );

  // await Hive.box(Constants.kRecordsBox).clear();

  runApp(myApp);
}
