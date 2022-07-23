import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/reports/summary_tile.dart';

import '../../blocs/report/models/price_list_report_data.dart';

class PriceListReport extends StatefulWidget {
  const PriceListReport({required this.data, Key? key}) : super(key: key);

  final PriceListReportData data;

  @override
  State<PriceListReport> createState() => _ReportState();
}

class _ReportState extends State<PriceListReport> {
  final selectedItemNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    final dimensionTitle = widget.data.dimension.shortTitle;
    final measureTitle = widget.data.measure.shortTitle;

    if (widget.data.products.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No Data'),
      ));
    }
    return Column(
      children: [
        Container(
          color: AppColors.surface,
          height: 50.dh,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.dw),
                      child: AppText(dimensionTitle.toUpperCase(),
                          size: 16.dw, weight: FontWeight.bold))),
              SizedBox(
                  width: 75,
                  child: Center(
                    child: AppText(
                      "UNIT",
                      size: 16.dw,
                      weight: FontWeight.bold,
                    ),
                  )),
              Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 15.dw),
                      child: AppText(measureTitle.toUpperCase(),
                          size: 16.dw, weight: FontWeight.bold))),
            ],
          ),
        ),
        _buildDataList(),
      ],
    );
  }

  _buildDataList() {
    final items = widget.data.products;
    if (items.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No Data'),
      ));
    }
    return Expanded(
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => AppDivider(
            margin: EdgeInsets.zero, color: AppColors.divider.shade300),
        itemBuilder: (_, index) {
          final item = items[index];
          return ValueListenableBuilder(
              valueListenable: selectedItemNotifier,
              builder: (_, selectedGroup, __) {
                final isSelected = selectedGroup == item;
                return GestureDetector(
                  onTap: () =>
                      selectedItemNotifier.value = isSelected ? '' : item.id,
                  child: PriceListReportTile(
                    product: widget.data.products[index],
                    tileColor:
                        isSelected ? AppColors.surface2 : AppColors.onPrimary,
                  ),
                );
              });
        },
      ),
    );
  }
}
