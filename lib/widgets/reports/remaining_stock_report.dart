import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/report_title.dart';

import '../../blocs/report/models/grouped_report_data.dart';

class RemainingStockReport extends StatelessWidget {
  final GroupedReportData groupedData;
  const RemainingStockReport(this.groupedData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportTitle(
            title1: groupedData.dimension.shortTitle,
            title2: groupedData.measure.shortTitle),
        Expanded(
          child: ListView(
              padding: EdgeInsets.only(bottom: 20.dh),
              shrinkWrap: true,
              children: List.generate(groupedData.groups.length, (index) {
                final group = groupedData.groups[index];
                return Container(
                  margin: EdgeInsets.only(top: 20.dh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.dw),
                        child: AppText(group.name.toUpperCase(),
                            weight: FontWeight.w500),
                      ),
                      const AppDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.dw),
                        child: Column(
                            children:
                                List.generate(group.items.length, (index) {
                          return SizedBox(
                            height: 45.dh,
                            child: ListTile(
                              title: AppText(group.items[index],
                                  color: AppColors.onBackground2),
                              trailing: AppText(
                                  Utils.convertToMoneyFormat(
                                      group.amounts[index]),
                                  weight: FontWeight.bold,
                                  opacity: .7),
                            ),
                          );
                        })),
                      )
                    ],
                  ),
                );
              })),
        )
      ],
    );
  }
}
