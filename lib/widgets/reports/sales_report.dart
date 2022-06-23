import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/blocs/filter/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/report_title.dart';
import 'package:inventory_management/widgets/reports/summary_tile.dart';

import '../../blocs/report/models/report_data.dart';

class Report extends StatefulWidget {
  const Report({required this.data, Key? key}) : super(key: key);

  final ReportData data;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final selectedItemNotifier = ValueNotifier<String>('');

  late final QueryFiltersBloc queryFilters;

  @override
  void initState() {
    queryFilters = BlocProvider.of<QueryFiltersBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportTitle(
            title1: widget.data.dimension.shortTitle,
            title2: widget.data.measure.shortTitle),
        _buildDataList(),
      ],
    );
  }

  _buildDataList() {
    final items = widget.data.items;
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
          final amount = widget.data.amounts[index];
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
