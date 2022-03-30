import '../source.dart';
import '../widgets/charts/bar_charts_flutter.dart';
import '../widgets/charts/bar_fl_charts.dart';
import '../widgets/charts/bar_syncfusion.dart';
import '../widgets/charts/pie_syncfusion.dart';
import '../widgets/charts/line_charts_flutter.dart';
import '../widgets/charts/line_fl_charts.dart';
import '../widgets/charts/line_syncfusion.dart';
import '../widgets/charts/pie_charts_flutter.dart';
import '../widgets/charts/pie_fl_chart.dart';
import '../widgets/dashboard_widgets/expenses_card.dart';
import '../widgets/dashboard_widgets/low_stock_products_card.dart';
import '../widgets/dashboard_widgets/profit_loss_card.dart';
import '../widgets/dashboard_widgets/quick_actions_card.dart';
import '../widgets/dashboard_widgets/recent_sales_card.dart';
import '../widgets/dashboard_widgets/revenue_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        drawer: const AppDrawer(),
        body: _buildCharts());
  }

  _buildAppBar() {
    final isScaffoldStateNull = _scaffoldKey.currentState == null;
    _openDrawer() {
      if (isScaffoldStateNull) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scaffoldKey.currentState!.openDrawer();
        });
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return AppTopBar(showDrawerCallback: _openDrawer);
  }

  _buildCharts() {
    return ListView(children: const [
      QuickActionsCard(),
      RecentSalesCard(),
      ProfitLossCard(),
      RevenueCard(),
      ExpensesCard(),
      LowStockProductsCard()
    ]);
  }
}
