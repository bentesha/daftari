import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/query_filters_bloc.dart';
import 'package:inventory_management/blocs/report_page_bloc.dart';
import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/widgets/reports/price_list.dart';
import 'package:inventory_management/widgets/reports/profit_loss_report.dart';
import 'package:inventory_management/widgets/reports/remaining_stock_report.dart';
import 'package:inventory_management/widgets/reports/sales_filter.dart';
import 'package:inventory_management/widgets/reports/sales_report.dart';
import 'package:inventory_management/widgets/type_selector_dialog.dart';
import '../source.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, this.reportType = ReportType.sales})
      : super(key: key);

  final ReportType reportType;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late ReportType reportType;
  late ReportPageBloc bloc;

  @override
  void initState() {
    reportType = widget.reportType;
    bloc = ReportPageBloc();
    final queryFilters = BlocProvider.of<QueryFilters>(context, listen: false);
    _init(queryFilters);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportPageBloc, ReportData>(
        bloc: bloc,
        builder: (_, data) {
          final type = data.reportType;
          return Scaffold(
              appBar: _buildAppBar(type),
              body: type.isSales || type.isPurchases || type.isExpenses
                  ? Report(data: data)
                  : type.isPriceList
                      ? const PriceList()
                      : type.isRemainingStock
                          ? const RemainingStockReport()
                          : type.isProfitLoss
                              ? const ProfitLossReport()
                              : Container());
        });
  }

  _buildAppBar(ReportType type) {
    return AppBar(
      title: Row(
        children: [
          AppMaterialButton(
            onPressed: () => _showTypeSelectorDialog(Types.reports),
            backgroundColor: AppColors.highlight.withOpacity(.05),
            padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5),
            borderRadius: BorderRadius.circular(15),
            child: Row(
              children: [
                AppText(type.reportName,
                    color: AppColors.onPrimary, size: 16.dw),
                const SizedBox(width: 8),
                Icon(Icons.expand_more, size: 20.dw)
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (type.hasFilters)
          AppIconButton(
              onPressed: _showFilters,
              icon: EvaIcons.swapOutline,
              iconThemeData: IconThemeData(size: 20.dw),
              margin: EdgeInsets.only(right: 19.dw)),
      ],
    );
  }

  _showTypeSelectorDialog(Types type) {
    final filters = BlocProvider.of<QueryFilters>(context);
    showDialog(
        context: context,
        builder: (_) {
          return TypeSelectorDialog<ReportType>(
              onSelected: (selected) {
                reportType = selected;
                _refresh(filters);
              },
              currentType: reportType,
              title: 'Reports');
        });
  }

  _init(QueryFilters filters) {
    final groupBy = (filters['groupBy'] as QueryFilter<GroupBy>).value;
    final sortDir =
        (filters['sortDirection'] as QueryFilter<SortDirection>).value;
    bloc.init(groupBy, sortDir, reportType);
  }

  _showFilters() async {
    final filters = BlocProvider.of<QueryFilters>(context);
    final hasAddedFilters = await SalesFilterDialog.navigateTo(context);
    //null means page is popped by the cancel button on the
    //right top side of the app-bar
    if (hasAddedFilters != null && hasAddedFilters) {
      _refresh(filters);
    }
  }

  _refresh(QueryFilters filters) => _init(filters);
}
