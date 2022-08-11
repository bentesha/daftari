import 'package:inventory_management/pages/current_date_documents_pages/current_date_purchases_docs_page.dart';
import 'package:inventory_management/pages/landing_pages/widgets/current_date_stats_header.dart';
import 'package:inventory_management/pages/landing_pages/widgets/quick_action_button.dart';

import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../source.dart';

class PurchasesLandingPage extends StatefulWidget {
  const PurchasesLandingPage({Key? key}) : super(key: key);

  @override
  State<PurchasesLandingPage> createState() => _PurchasesLandingPageState();
}

class _PurchasesLandingPageState extends State<PurchasesLandingPage> {
  @override
  Widget build(BuildContext context) {
    final purchases = context.watch<DashBoardBloc>().state.todayStats.purchases;

    return Scaffold(
      backgroundColor: AppColors.surface2,
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        children: [
          CurrentDateStatsHeader(
              total: purchases,
              onViewDetailsTap: () {
                if (purchases == 0) return;
                push(const CurrentDatePurchasesDocsPage());
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
                onPressed: () => push(const PurchasesDocumentsPage()),
              ),
              QuickActionButton(
                icon: Icons.add_shopping_cart,
                label: "Add New Purchase",
                onPressed: () => push(const DocumentPurchasesPage()),
              ),
              QuickActionButton(
                icon: Icons.qr_code,
                label: "Add New Product",
                onPressed: () => push(const ProductPage()),
              ),
              QuickActionButton(
                icon: Icons.price_check,
                label: "Price List",
                onPressed: () => push(const ReportPage(
                  reportType: ReportType.priceList,
                )),
              ),
              QuickActionButton(
                icon: Icons.inventory_2,
                label: "Stock-Status Report",
                onPressed: () => push(const ReportPage(
                  reportType: ReportType.remainingStock,
                )),
              ),
              QuickActionButton(
                icon: Icons.bar_chart,
                label: "Purchases Report",
                onPressed: () => push(const ReportPage(
                  reportType: ReportType.purchases,
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
