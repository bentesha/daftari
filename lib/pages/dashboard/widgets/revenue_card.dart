import 'package:intl/intl.dart';
import 'package:inventory_management/source.dart';
import '../../../models/breakdown_data.dart';
import 'charts/bar_chart.dart';

class BreakdownDataCard extends StatelessWidget {
  final List<BreakdownData> data;
  final String title;
  final VoidCallback onViewBreakdownCallback;
  const BreakdownDataCard(this.data,
      {required this.onViewBreakdownCallback, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final thisMonth = DateFormat('MMMM, yyyy').format(now);

    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 15.dh),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, size: 15.dw, weight: FontWeight.bold),
          AppText('By Category: $thisMonth',
              size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          if (data.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(child: Text('No data')),
            ),
          if (data.isNotEmpty)
            CustomBarChart(data,
                valueColor: title == 'Revenue'
                    ? AppColors.primaryVariant
                    : const Color(0xff88292F)),
          if (data.isNotEmpty)
            AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          if (data.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText('Total: Tzs ${_getTotal()}',
                    weight: FontWeight.bold,
                    size: 15.dw,
                    color: AppColors.onBackground2),
                AppButton(
                    onPressed: onViewBreakdownCallback,
                    child: AppText('View Breakdown',
                        color: AppColors.primary, size: 15.dw),
                    radius: 8.dw,
                    highlightDetails: HighlightDetails(10.dw, 10.dh)),
              ],
            )
        ],
      ),
    );
  }

  String _getTotal() {
    final total =
        data.fold<double>(0, (value, current) => value + current.amount);
    return Utils.convertToMoneyFormat(total);
  }
}
