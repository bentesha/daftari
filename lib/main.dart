import 'package:provider/single_child_widget.dart';

import 'app.dart';
import 'blocs/filter/query_filters_bloc.dart';
import 'package:provider/provider.dart';

import 'source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final myApp = MultiProvider(
      providers: serviceProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child: const MyApp(),
      ));

  runApp(myApp);
}

final blocProviders = <BlocProvider>[
  BlocProvider<QueryFiltersBloc>(create: (_) => QueryFiltersBloc()),
];

final serviceProviders = <SingleChildWidget>[
  _createProvider<ProductsService>(ProductsService()),
  _createProvider<SalesService>(SalesService()),
  _createProvider<PurchasesService>(PurchasesService()),
  _createProvider<CategoriesService>(CategoriesService()),
  _createProvider<WriteOffsService>(WriteOffsService()),
  _createProvider<ExpensesService>(ExpensesService()),
  _createProvider<OpeningStockItemsService>(OpeningStockItemsService()),
];

_createProvider<T extends ChangeNotifier>(var service) =>
    ChangeNotifierProvider<T>(create: (_) => service);
