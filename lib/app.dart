import 'source.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSizeInit(
      designSize: const Size(411.4, 866.3),
      child: MaterialApp(
        title: 'Inventory Management App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData(),
        navigatorKey: navigatorKey,
        home: const DashboardPage(),
      ),
    );
  }
}
