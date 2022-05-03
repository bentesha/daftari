import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/datatable_data/common.dart';
import 'package:inventory_management/widgets/datatable_data/expenses.dart';
import 'package:inventory_management/widgets/reports/summary_tile.dart';
import '../datatable_data/expenses.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key? key}) : super(key: key);

  @override
  State<ExpenseReport> createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  final isSummaryVisibleNotifier = ValueNotifier<bool>(true);
  final selectedGroupNotifier = ValueNotifier<String>('');
  final longPressedGroupNotifier = ValueNotifier<String>('');
  late List<Group> expenses;
  late Group topSpendingGroup;
  late double allGroupsTotal;

  @override
  void initState() {
    final random = Random();
    final _expenses = <Group>[];
    for (var group in expenseGroups) {
      if (group.data == null) {
        _expenses.add(group.copyWithTotal(random.nextDouble() * 1243500));
      } else {
        final _data = <Data>[];
        for (var data in group.data!) {
          _data.add(data.copyWithTotal(random.nextDouble() * 556700));
        }
        final total =
            _data.fold<double>(0, (prev, current) => prev + current.total);
        _data.sort((a, b) => b.total.compareTo(a.total));
        _expenses.add(Group(group.title, data: _data, total: total));
      }
    }
    _expenses.sort((a, b) => b.total.compareTo(a.total));
    expenses = _expenses;
    topSpendingGroup = _expenses[0];
    allGroupsTotal =
        _expenses.fold<double>(0, (prev, current) => prev + current.total);
    super.initState();
  }

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
        itemCount: expenses.length,
        separatorBuilder: (_, __) => AppDivider(
            margin: EdgeInsets.zero, color: AppColors.divider.shade300),
        itemBuilder: (_, index) {
          final group = expenses[index];
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
                          InkWell(
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
                            child: Container(
                                height: 40.dh,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 15.dw),
                                color: isLongPressed
                                    ? AppColors.primary
                                    : isSelected
                                        ? AppColors.surface2
                                        : AppColors.onPrimary,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(group.title,
                                          color: isLongPressed
                                              ? AppColors.onPrimary
                                              : AppColors.onBackground,
                                          weight: isLongPressed
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                      AppText(
                                          Utils.convertToMoneyFormat(
                                              group.total),
                                          color: isLongPressed
                                              ? AppColors.onPrimary
                                              : AppColors.onBackground2,
                                          weight: isLongPressed
                                              ? FontWeight.bold
                                              : FontWeight.w500),
                                    ])),
                          ),
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
                                    return Container(
                                      height: 40.dh,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.dw),
                                      color: AppColors.surface2,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(data.title, size: 14.dw),
                                            AppText(
                                                Utils.convertToMoneyFormat(
                                                    data.total),
                                                color: AppColors.onBackground2,
                                                weight: FontWeight.w500),
                                          ]),
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
                        icon: isSummaryVisible ? EvaIcons.minus : EvaIcons.plus,
                        iconThemeData:
                            const IconThemeData(color: AppColors.onBackground),
                      )
                    ],
                  )),
              isSummaryVisible
                  ? Column(
                      children: [
                        SummaryTile(
                            title: 'Top-spend category',
                            name: topSpendingGroup.title,
                            value: topSpendingGroup.total),
                        const AppDivider(margin: EdgeInsets.zero),
                        AppDivider(
                            margin: EdgeInsets.zero,
                            color: AppColors.divider.shade300),
                        SummaryTile(
                            name: 'Total Expenses', value: allGroupsTotal)
                      ],
                    )
                  : const AppDivider.zeroMargin()
            ],
          );
        });
  }
}
