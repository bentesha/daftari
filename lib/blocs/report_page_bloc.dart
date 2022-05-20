import 'package:inventory_management/blocs/query_filters_bloc.dart';
import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/reports/data.dart';

class ReportPageBloc extends Cubit<ReportData> {
  ReportPageBloc() : super(ReportData.empty());

  void init(GroupBy groupBy, SortDirection sortDirection, ReportType type) {
    late final List<String> items;
    switch (groupBy) {
      case GroupBy.day:
        items = days;
        break;
      case GroupBy.month:
        items = months;
        break;
      case GroupBy.quarter:
        items = quarters;
        break;
      case GroupBy.year:
        items = years;
        break;
      case GroupBy.item:
        items = products;
        break;
      case GroupBy.category:
        items = type.isExpenses ? expenseCategories : productCategories;
        break;
    }
    final amounts = Utils.getRandomAmounts();
    if (sortDirection == SortDirection.ascending) {
      amounts.sort((a, b) => a.compareTo(b));
    } else {
      amounts.sort((a, b) => b.compareTo(a));
    }
    emit(ReportData(type, items, amounts));
  }

  void refresh(
      GroupBy groupBy, SortDirection sortDirection, ReportType report) {
    init(groupBy, sortDirection, report);
  }
}

class ReportData {
  final ReportType reportType;
  final List<String> items;
  final List<double> amounts;
  const ReportData(this.reportType, this.items, this.amounts);

  ReportData.empty()
      : items = [],
        reportType = ReportType.sales,
        amounts = [];
}
