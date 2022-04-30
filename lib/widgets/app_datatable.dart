import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/datatable_data/sales.dart';
import 'package:inventory_management/widgets/reports/summary_tile.dart';

class AppDataTable extends StatefulWidget {
  const AppDataTable({Key? key}) : super(key: key);

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  final isSummaryVisibleNotifier = ValueNotifier<bool>(true);
  final selectedGroupNotifier = ValueNotifier<String>('');
  final longPressedGroupNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSummary(),
        _buildTitles(),
        _buildDataList(),
      ],
    );
  }

  _buildTitles() {
    return Container(
      color: AppColors.surface,
      height: 50.dh,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.dw),
                  child: AppText('CATEGORY',
                      size: 16.dw, weight: FontWeight.bold))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.dw),
                  child:
                      AppText('AMOUNT', size: 16.dw, weight: FontWeight.bold))),
        ],
      ),
    );
  }

  _buildDataList() {
    return Expanded(
      child: ListView.separated(
        itemCount: groups.length,
        separatorBuilder: (_, __) => AppDivider(
            margin: EdgeInsets.zero, color: AppColors.divider.shade300),
        itemBuilder: (_, index) {
          final group = groups[index];
          return ValueListenableBuilder(
              valueListenable: longPressedGroupNotifier,
              builder: (_, longPressedGroup, __) {
                final isLongPressed = longPressedGroup == group.title;
                return ValueListenableBuilder(
                    valueListenable: selectedGroupNotifier,
                    builder: (_, selectedGroup, __) {
                      final isSelected = selectedGroup == group.title;
                      return Column(
                        children: [
                          SizedBox(
                              height: 40.dh,
                              child: ListTile(
                                tileColor: isLongPressed
                                    ? AppColors.primary
                                    : isSelected
                                        ? AppColors.surface2
                                        : AppColors.onPrimary,
                                onTap: () {
                                  selectedGroupNotifier.value =
                                      isSelected ? '' : group.title;
                                  longPressedGroupNotifier.value = '';
                                },
                                onLongPress: () {
                                  longPressedGroupNotifier.value =
                                      isLongPressed ? '' : group.title;
                                  selectedGroupNotifier.value = '';
                                },
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15.dw),
                                title: AppText(group.title,
                                    color: isLongPressed
                                        ? AppColors.onPrimary
                                        : AppColors.onBackground,
                                    weight: isLongPressed
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                                trailing: AppText(
                                    Utils.convertToMoneyFormat(group.total),
                                    color: isLongPressed
                                        ? AppColors.onPrimary
                                        : AppColors.onBackground2,
                                    weight: isLongPressed
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                              )),
                          isLongPressed && group.data != null
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (_, __) =>
                                      AppDivider.zeroMargin(
                                          color: AppColors.divider.shade300),
                                  itemCount: group.data!.length,
                                  itemBuilder: (_, index) {
                                    final data = group.data![index];
                                    return SizedBox(
                                      height: 40.dh,
                                      child: ListTile(
                                        tileColor: AppColors.surface2,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.dw),
                                        title: AppText(data.title, size: 14.dw),
                                        trailing: AppText(
                                            Utils.convertToMoneyFormat(
                                                data.total),
                                            weight: FontWeight.w500),
                                      ),
                                    );
                                  },
                                )
                              : Container()
                        ],
                      );
                    });
              });
        },
      ),
    );
  }

  _buildSummary() {
    return ValueListenableBuilder<bool>(
        valueListenable: isSummaryVisibleNotifier,
        builder: (_, isSummaryVisible, __) {
          return Column(
            children: [
              Container(
                  height: 50.dh,
                  color: AppColors.surface,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 15.dw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText('SUMMARY', size: 16.dw, weight: FontWeight.bold),
                      AppIconButton(
                        onPressed: () {
                          isSummaryVisibleNotifier.value =
                              !isSummaryVisibleNotifier.value;
                        },
                        icon: isSummaryVisible
                            ? FontAwesomeIcons.minus
                            : FontAwesomeIcons.plus,
                        iconThemeData:
                            const IconThemeData(color: AppColors.onBackground),
                      )
                    ],
                  )),
              isSummaryVisible
                  ? Column(
                      children: [
                        const SummaryTile(
                            title: 'Top selling category',
                            name: 'Breads',
                            value: 3000500600),
                        AppDivider(
                            margin: EdgeInsets.zero,
                            color: AppColors.divider.shade300),
                        const SummaryTile(
                            title: 'Top selling item',
                            name: 'Pepsi 1.0L',
                            value: 4560000),
                        AppDivider(
                            margin: EdgeInsets.zero,
                            color: AppColors.divider.shade300),
                        const SummaryTile(
                            title: 'Total Sales',
                            name: '345 sales',
                            value: 4560000),
                      ],
                    )
                  : const AppDivider.zeroMargin()
            ],
          );
        });
  }
}
