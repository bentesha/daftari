import 'package:inventory_management/blocs/dashboard/dashboard_bloc.dart';
import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';

import '../source.dart';
import '../widgets/dashboard_widgets/low_stock_products_card.dart';
import '../widgets/dashboard_widgets/profit_loss_card.dart';
import '../widgets/dashboard_widgets/quick_actions_card.dart';
import '../widgets/dashboard_widgets/recent_sales_card.dart';
import '../widgets/dashboard_widgets/revenue_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final DashBoardBloc bloc;

  @override
  void initState() {
    bloc = DashBoardBloc();
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error!),
                          const SizedBox(height: 20),
                          AppTextButton(
                              backgroundColor: AppColors.primary,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              onPressed: bloc.getData,
                              text: 'Try Again')
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: bloc.getData,
                      color: AppColors.primary,
                      child: ListView(children: [
                        const QuickActionsCard(),
                        RecentSalesCard(state.recentSales),
                        const ProfitLossCard(),
                        BreakdownDataCard(
                          state.revenueBreakdownData,
                          title: 'Revenue',
                          onViewBreakdownCallback: () =>
                              push(const ReportsPage()),
                        ),
                        BreakdownDataCard(
                          state.expensesBreakdownData,
                          title: 'Expenses',
                          onViewBreakdownCallback: () => push(const ReportsPage(
                              reportType: ReportType.expenses)),
                        ),
                        LowStockProductsCard(state.products)
                      ]),
                    );
        });
  }
}
