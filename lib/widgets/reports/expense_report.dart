import 'dart:math';
import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/report_title.dart';
import 'package:inventory_management/widgets/reports/summary_tile.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport(this.queryOptions, {required this.items, Key? key})
      : super(key: key);

  final QueryOptions queryOptions;
  final List<String> items;

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  final selectedItemNotifier = ValueNotifier<String>('');
  final amounts = <double>[];

  @override
  void initState() {
    final random = Random();
    for (int index = 0; index < 11; index++) {
      amounts.add(random.nextDouble() * 1234500);
      if (widget.queryOptions.sortDirection == SortDirection.ascending) {
        amounts.sort((a, b) => a.compareTo(b));
      } else {
        amounts.sort((a, b) => b.compareTo(a));
      }
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportTitle(title1: widget.queryOptions.groupBy, title2: 'amount'),
        _buildDataList(),
      ],
    );
  }

  _buildDataList() {
    final items = widget.items;
    return Expanded(
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => AppDivider(
            margin: EdgeInsets.zero, color: AppColors.divider.shade300),
        itemBuilder: (_, index) {
          final amount = amounts[index];
          final item = items[index];
          return ValueListenableBuilder(
              valueListenable: selectedItemNotifier,
              builder: (_, selectedGroup, __) {
                final isSelected = selectedGroup == item;
                return GestureDetector(
                  onTap: () =>
                      selectedItemNotifier.value = isSelected ? '' : item,
                  child: ReportTile(
                    name: item,
                    value: amount,
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
