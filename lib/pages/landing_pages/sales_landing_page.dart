import 'package:inventory_management/blocs/dashboard/dashboard_bloc.dart';
import 'package:inventory_management/pages/current_date_documents_pages/current_date_sales_docs_page.dart';

import '../../source.dart';
import 'widgets/current_date_stats_header.dart';
import 'widgets/quick_action_button.dart';

class SalesLandingPage extends StatefulWidget {
  const SalesLandingPage({Key? key}) : super(key: key);

  @override
  State<SalesLandingPage> createState() => _SalesLandingPageState();
}

class _SalesLandingPageState extends State<SalesLandingPage> {
  @override
  Widget build(BuildContext context) {
    final sales = context.watch<DashBoardBloc>().state.todayStats.sales;

    return Scaffold(
      backgroundColor: AppColors.surface2,
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        children: [
          CurrentDateStatsHeader(
              total: sales,
              onViewDetailsTap: () {
                if (sales == 0) return;
                push(const CurrentDateSalesDocsPage());
              }),
          const SizedBox(height: 40),
          const Text("Quick Actions",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20.dw,
            children: [
              QuickActionButton(
                icon: Icons.arrow_forward,
                label: "View All",
                onPressed: () => push(const SalesDocumentsPage()),
              ),
              QuickActionButton(
                icon: Icons.sell,
                label: "Add New Sales",
                onPressed: () => push(const DocumentSalesPage()),
              ),
              QuickActionButton(
                icon: Icons.qr_code,
                label: "Add New Product",
                onPressed: () => push(const ProductPage()),
              ),
              QuickActionButton(
                icon: Icons.bar_chart,
                label: "Sales Report",
                onPressed: () => push(const ReportPage()),
              ),
              QuickActionButton(
                icon: Icons.account_balance,
                label: "Profit/Loss Report",
                onPressed: () => push(const ReportPage(
                  reportType: ReportType.profitLoss,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
