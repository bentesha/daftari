import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/blocs/report/report_page_bloc.dart';
import 'package:inventory_management/widgets/reports/inventory_movement_report.dart';
import 'package:inventory_management/widgets/reports/profit_loss_report.dart';
import 'package:inventory_management/widgets/reports/sales_filter.dart';
import 'package:inventory_management/widgets/reports/sales_report.dart';
import '../source.dart';
import '../widgets/reports/grouped_data_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key, this.reportType = ReportType.sales})
      : super(key: key);

  final ReportType reportType;

  @override
  State<ReportPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportPage> {
  late ReportType reportType;
  late ReportPageBloc bloc;

  @override
  void initState() {
    reportType = widget.reportType;
    final queryFiltersBloc =
        BlocProvider.of<QueryFiltersBloc>(context, listen: false);
    // refreshing when coming from a different page
    queryFiltersBloc.refresh(widget.reportType);
    bloc = ReportPageBloc(queryFiltersBloc);
    bloc.init(reportType);
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
                          onPressed: () => _refresh(state.type),
                          backgroundColor: AppColors.primary,
                          height: 50,
                          text: 'Retry')
                    ],
                  ),
                ),
              ),
            );
          }

          final type = state.type;

          return Scaffold(
              appBar: _buildAppBar(type),
              body: state.hasGroupedReportData
                  ? GroupedDataReport(state.groupedReportData!)
                  : type.isInventoryMovement
                      ? InventoryMovementReport(
                          state.inventoryMovements, state.data,
                          onTappedToSelect: () => _showFilters(type))
                      : type.isProfitLoss
                          ? const ProfitLossReport()
                          : Report(data: state.data!));
        });
  }

  _buildAppBar(ReportType type) {
    return AppBar(
      title: AppText(type.reportName, color: AppColors.onPrimary, size: 16.dw),
      actions: [
        if (type.hasFilters)
          AppIconButton(
              onPressed: () => _showFilters(type),
              icon: EvaIcons.swapOutline,
              iconThemeData: IconThemeData(size: 20.dw),
              margin: EdgeInsets.only(right: 19.dw)),
      ],
    );
  }

  _showFilters(ReportType reportType) async {
    final hasAddedFilters =
        await SalesFilterDialog.navigateTo(context, reportType);
    // null means page is popped by the cancel button on the
    // right top side of the app-bar
    if (hasAddedFilters != null && hasAddedFilters) _refresh(reportType);
  }

  _refresh(ReportType reportType) => bloc.init(reportType);
}
