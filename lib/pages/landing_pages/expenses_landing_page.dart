import 'package:inventory_management/pages/current_date_documents_pages/current_date_expenses_docs_page.dart';
import 'package:inventory_management/pages/landing_pages/widgets/current_date_stats_header.dart';
import 'package:inventory_management/pages/landing_pages/widgets/quick_action_button.dart';

import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../source.dart';

class ExpensesLandingPage extends StatefulWidget {
  const ExpensesLandingPage({Key? key}) : super(key: key);

  @override
  State<ExpensesLandingPage> createState() => _ExpensesLandingPageState();
}

class _ExpensesLandingPageState extends State<ExpensesLandingPage> {
  @override
  Widget build(BuildContext context) {
    final expenses = context.watch<DashBoardBloc>().state.todayStats.expenses;

    return Scaffold(
      backgroundColor: AppColors.surface2,
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        children: [
          CurrentDateStatsHeader(
              total: expenses,
              onViewDetailsTap: () {
                if (expenses == 0) return;
                push(const CurrentDateExpensesDocsPage());
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
                onPressed: () => push(const ExpensesDocumentsPage()),
              ),
              QuickActionButton(
                icon: Icons.paid,
                label: "Add New Expense",
                onPressed: () => push(const DocumentExpensesPage()),
              ),
              QuickActionButton(
                icon: Icons.qr_code,
                label: "Add New Category",
                onPressed: () => push(const CategoryEditPage(
                  categoryType: CategoryTypes.expenses,
                )),
              ),
              QuickActionButton(
                icon: Icons.bar_chart,
                label: "Expenses Report",
                onPressed: () => push(const ReportPage(
                  reportType: ReportType.expenses,
                )),
              ),
              QuickActionButton(
                icon: Icons.sell,
                label: "Sales Report",
                onPressed: () => push(const ReportPage()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
