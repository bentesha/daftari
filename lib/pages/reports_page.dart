import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/widgets/reports/expense_report.dart';
import 'package:inventory_management/widgets/reports/price_list.dart';
import 'package:inventory_management/widgets/reports/profit_loss_report.dart';
import 'package:inventory_management/widgets/reports/remaining_stock_report.dart';
import 'package:inventory_management/widgets/reports/sales_report.dart';
import 'package:inventory_management/widgets/type_selector_dialog.dart';
import '../source.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, this.reportType = 'Sales'}) : super(key: key);

  final String reportType;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late String reportType;

  @override
  void initState() {
    reportType = widget.reportType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool showFilter = reportType == 'Sales' || reportType == 'Expenses';
    return Scaffold(
        appBar: PageAppBar(
          title: _getTitle(),
          actionCallbacks: showFilter
              ? [
                  () => _showTypeSelectorDialog(Types.reports),
                  () => _showTypeSelectorDialog(Types.dimensions)
                ]
              : [() => _showTypeSelectorDialog(Types.reports)],
          actionIcons: showFilter
              ? const [EvaIcons.swapOutline, EvaIcons.funnelOutline]
              : const [EvaIcons.swapOutline],
        ),
        body: reportType == 'Sales'
            ? const SalesReport()
            : reportType == 'Price List'
                ? const PriceList()
                : reportType == 'Remaining Stock'
                    ? const RemainingStockReport()
                    : reportType == 'Profit & Loss'
                        ? const ProfitLossReport()
                        : const ExpenseReport());
  }

  _showTypeSelectorDialog(Types type) {
    showDialog(
        context: context,
        builder: (_) {
          return TypeSelectorDialog(
              onSelected: (selected) {
                reportType = selected;
                setState(() {});
              },
              currentType: reportType,
              type: type,
              title: type == Types.reports ? 'Reports' : 'Duration');
        });
  }

  String _getTitle() {
    if (reportType == 'Sales') return 'Sales Report';
    if (reportType == 'Price List') return 'Price List';
    if (reportType == 'Remaining Stock') return 'Remaining Stock Report';
    if (reportType == 'Expenses') return 'Expenses Report';
    return 'Profit & Loss Report';
  }
}
