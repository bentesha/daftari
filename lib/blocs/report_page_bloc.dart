import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/extensions.dart/report_type.dart';
import 'package:inventory_management/widgets/reports/data.dart';

class ReportPageBloc extends Cubit<ReportData> {
  ReportPageBloc() : super(ReportData.empty());

  void init(QueryOptions options, ReportType report) {
    late final List<String> items;
    switch (options.groupBy) {
      case 'day':
        items = days;
        break;
      case 'month':
        items = months;
        break;
      case 'quarter':
        items = quarters;
        break;
      case 'year':
        items = years;
        break;
      case 'item':
        items = products;
        break;
      case 'category':
        items = report.isExpenses ? expenseCategories : productCategories;
        break;
    }
    final amounts = Utils.getRandomAmounts();
    if (options.sortDirection == SortDirection.ascending) {
      amounts.sort((a, b) => a.compareTo(b));
    } else {
      amounts.sort((a, b) => b.compareTo(a));
    }
    emit(ReportData(items, amounts));
  }

  void refresh(QueryOptions options, ReportType report) =>
      init(options, report);
}

class ReportData {
  final List<String> items;
  final List<double> amounts;
  const ReportData(this.items, this.amounts);

  ReportData.empty()
      : items = [],
        amounts = [];
}
