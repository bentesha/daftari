import 'app.dart';
import 'source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final myApp = MultiProvider(
    providers: [
      _createProvider<ProductsService>(ProductsService()),
      _createProvider<SalesService>(SalesService()),
      _createProvider<PurchasesService>(PurchasesService()),
      _createProvider<CategoriesService>(CategoriesService()),
      _createProvider<WriteOffsService>(WriteOffsService()),
      _createProvider<ExpensesService>(ExpensesService()),
      _createProvider<OpeningStockItemsService>(OpeningStockItemsService()),
    ],
    child: const MyApp(),
  );

  runApp(myApp);
}

_createProvider<T extends ChangeNotifier>(var service) =>
    ChangeNotifierProvider<T>(create: (_) => service);
