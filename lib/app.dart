import 'source.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Widget firstScreen;

  @override
  void initState() {
    firstScreen = _getFirstPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSizeInit(
      designSize: const Size(411.4, 866.3),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData(),
        home: firstScreen,
      ),
    );
  }

  Widget _getFirstPage() {
    final hasCategories = Hive.box(Constants.kCategoriesBox).isNotEmpty;
    final hasItems = Hive.box(Constants.kItemsBox).isNotEmpty;

    if (!hasCategories || !hasItems) return const CategoriesPage();
    return const SalesRecordsPage();
  }
}
