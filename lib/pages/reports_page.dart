import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/report_page_bloc.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/utils/extensions.dart/report_type.dart';
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
  var queryOptions = QueryOptions('category');

  @override
  void initState() {
    reportType = widget.reportType;
    bloc = ReportPageBloc();
    bloc.init(queryOptions, reportType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PageAppBar(
          title: reportType.reportName,
          actionCallbacks: reportType.hasFilters
              ? [
                  () => _showTypeSelectorDialog(Types.reports),
                  () async {
                    final options = await SalesFilterDialog.navigateTo(
                        context, queryOptions);
                    //null means page is popped by the cancel button on the
                    //right top side of the app-bar
                    if (options != null) {
                      queryOptions = options;
                      bloc.refresh(queryOptions, reportType);
                      setState(() {});
                    }
                  }
                ]
              : [() => _showTypeSelectorDialog(Types.reports)],
          actionIcons: reportType.hasFilters
              ? const [EvaIcons.swapOutline, EvaIcons.funnelOutline]
              : const [EvaIcons.swapOutline],
        ),
        body: reportType.isPriceList
            ? const PriceList()
            : reportType.isRemainingStock
                ? const RemainingStockReport()
                : reportType.isProfitLoss
                    ? const ProfitLossReport()
                    : _buildReport());
  }

  _showTypeSelectorDialog(Types type) {
    showDialog(
        context: context,
        builder: (_) {
          return TypeSelectorDialog<ReportType>(
              onSelected: (selected) {
                reportType = selected;
                bloc.refresh(queryOptions, reportType);
                setState(() {});
              },
              currentType: reportType,
              title: 'Reports');
        });
  }

  _buildReport() {
    return BlocBuilder<ReportPageBloc, ReportData>(
        bloc: bloc,
        builder: (_, data) {
          return reportType.isSales ||
                  reportType.isPurchases ||
                  reportType.isExpenses
              ? Report(queryOptions, data: data)
              : Container();
        });
  }
}
