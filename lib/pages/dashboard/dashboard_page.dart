import 'package:inventory_management/blocs/dashboard/dashboard_bloc.dart';
import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';

import '../../source.dart';
import 'widgets/inventory_movement_card.dart';
import 'widgets/low_stock_products_card.dart';
import 'widgets/profit_loss_card.dart';
import 'widgets/quick_actions_card.dart';
import 'widgets/recent_sales_card.dart';
import 'widgets/revenue_card.dart';
import 'widgets/today_stats_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final DashBoardBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<DashBoardBloc>(context, listen: false);
    bloc.getData();
    super.initState();
  }

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scaffoldKey.currentState!.openDrawer();
        });
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return AppTopBar(showDrawerCallback: _openDrawer);
  }

  _buildCharts() {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
        bloc: bloc,
        builder: (_, state) {
          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.hasError
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error!, textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            AppTextButton(
                                backgroundColor: AppColors.primary,
                                height: 50,
                                onPressed: bloc.getData,
                                text: 'Try Again')
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: bloc.getData,
                      color: AppColors.primary,
                      child: ListView(children: [
                        const QuickActionsCard(),
                        TodayStatsCard(state.todayStats),
                        RecentSalesCard(state.recentSales),
                        ProfitLossCard(state.profitData),
                        BreakdownDataCard(
                          state.revenueBreakdownData,
                          title: 'Revenue',
                          onViewBreakdownCallback: () =>
                              push(const ReportPage()),
                        ),
                        BreakdownDataCard(
                          state.expensesBreakdownData,
                          title: 'Expenses',
                          onViewBreakdownCallback: () => push(const ReportPage(
                              reportType: ReportType.expenses)),
                        ),
                        LowStockProductsCard(state.products),
                        InventoryMovementCard(state.productsInventorySummary)
                      ]),
                    );
        });
  }
}
