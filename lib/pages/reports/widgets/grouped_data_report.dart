import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/report_title.dart';

import '../../../blocs/report/models/grouped_report_data.dart';

class GroupedDataReport extends StatefulWidget {
  final GroupedReportData groupedData;
  const GroupedDataReport(this.groupedData, {Key? key}) : super(key: key);

  @override
  State<GroupedDataReport> createState() => _GroupedDataReportState();
}

class _GroupedDataReportState extends State<GroupedDataReport> {
  late ValueNotifier<String> selectedCategoryNotifier;

  @override
  void initState() {
    selectedCategoryNotifier =
        ValueNotifier<String>(widget.groupedData.groups.first.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReportTitle(
            title1: widget.groupedData.dimension.shortTitle,
            title2: widget.groupedData.measure.shortTitle),
        Expanded(
            child: ListView.separated(
          itemCount: widget.groupedData.groups.length,
          padding: EdgeInsets.only(bottom: 20.dh),
          shrinkWrap: true,
          separatorBuilder: (_, __) => const AppDivider.zeroMargin(),
          itemBuilder: (_, index) {
            return ValueListenableBuilder<String>(
                valueListenable: selectedCategoryNotifier,
                builder: (_, selectedCategory, child) {
                  final group = widget.groupedData.groups[index];
                  final isSelected = selectedCategory == group.name;
                  return isSelected
                      ? _selectedCategory(group)
                      : _unselectedCategory(group);
                });
          },
        ))
      ],
    );
  }

  Widget _unselectedCategory(Group group) {
    return SizedBox(
      height: 45.dh,
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.dw),
          title:
              AppText(group.name.toUpperCase(), color: AppColors.onBackground),
          trailing: AppIconButton(
              icon: EvaIcons.plus,
              iconThemeData: const IconThemeData(color: Colors.black87),
              onPressed: () {
                selectedCategoryNotifier.value = group.name;
              })),
    );
  }

  Widget _selectedCategory(Group group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 10.dh),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(group.name.toUpperCase(), weight: FontWeight.w500),
              AppIconButton(
                  icon: EvaIcons.minus,
                  iconThemeData: const IconThemeData(color: Colors.black87),
                  onPressed: () {
                    selectedCategoryNotifier.value = '';
                  })
            ],
          ),
        ),
        const AppDivider.zeroMargin(height: 2, color: Colors.black),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.dw),
          child: Column(
              children: List.generate(group.items.length, (index) {
            return SizedBox(
              height: 45.dh,
              child: ListTile(
                title:
                    AppText(group.items[index], color: AppColors.onBackground2),
                trailing: AppText(
                    Utils.convertToMoneyFormat(group.amounts[index]),
                    weight: FontWeight.bold,
                    opacity: .7),
              ),
            );
          })),
        )
      ],
    );
  }
}
