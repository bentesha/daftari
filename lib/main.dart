import 'app.dart';
import 'source.dart';

//todo implement price list
//todo change view breakdowns - details & for both expenses and incomes
//todo handle drawer navigation, especially when popped - page navigated from should be marked as active

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
