import 'package:inventory_management/source.dart';

import '../../pages/reports_page.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.all(10.dw),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('Quick Actions', size: 15.dw, weight: FontWeight.bold),
          AppText('Tap & Go', size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 15.dh)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(() => push(const DocumentSalesPage()), 'New Sales',
                  Icons.sell),
              _buildIcon(() => push(const DocumentExpensesPage()),
                  'New Expense', Icons.post_add),
              _buildIcon(
                  () =>
                      push(const ReportPage(reportType: ReportType.priceList)),
                  'Price List',
                  Icons.fact_check),
              _buildIcon(() => push(const ReportsSelectorPage()), 'Reports',
                  Icons.bar_chart)
            ],
          )
        ],
      ),
    );
  }

  _buildIcon(VoidCallback onPressed, String value, IconData icon) {
    return AppMaterialButton(
      onPressed: onPressed,
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dh),
      borderRadius: BorderRadius.all(Radius.circular(10.dw)),
      child: Column(
        children: [
          Icon(icon, color: AppColors.onBackground2),
          SizedBox(height: 5.dh),
          AppText(value, size: 13.dw)
        ],
      ),
    );
  }
}
