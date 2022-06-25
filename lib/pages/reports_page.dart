import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/blocs/report/report_page_bloc.dart';
import 'package:inventory_management/blocs/filter/query_options.dart';
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
    final queryFiltersBloc =
        BlocProvider.of<QueryFiltersBloc>(context, listen: false);
    bloc = ReportPageBloc(queryFiltersBloc);
    _init(queryFiltersBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportPageBloc, ReportPageState>(
        bloc: bloc,
        builder: (_, state) {
          if (state.isLoading) {
            return const AppLoadingIndicator.withScaffold();
          }
          if (state.hasError) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      AppTextButton(
                          onPressed: () {
                            _init(BlocProvider.of<QueryFiltersBloc>(context));
                          },
                          backgroundColor: AppColors.primary,
                          height: 50,
                          text: 'Retry')
                    ],
                  ),
                ),
              ),
            );
          }

          final type = state.data.reportType;
          return Scaffold(
              appBar: _buildAppBar(type),
              body: type.isSales || type.isPurchases || type.isExpenses
                  ? Report(data: state.data)
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
    final filters = BlocProvider.of<QueryFiltersBloc>(context);
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

  _init(QueryFiltersBloc filters) {
    final groupBy = (filters['groupBy'] as QueryFilter<GroupBy>).value;
    final sortDir =
        (filters['sortDirection'] as QueryFilter<SortDirection>).value;
    bloc.init(groupBy, sortDir, reportType);
  }

  _showFilters() async {
    final filters = BlocProvider.of<QueryFiltersBloc>(context);
    final hasAddedFilters = await SalesFilterDialog.navigateTo(context);
    // null means page is popped by the cancel button on the
    // right top side of the app-bar
    if (hasAddedFilters != null && hasAddedFilters) {
      _refresh(filters);
    }
  }

  _refresh(QueryFiltersBloc filters) => _init(filters);
}
