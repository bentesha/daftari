import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/reports/data.dart';
import '../../repository/reports/reports_repository.dart';
import '../filter/query_filters_bloc.dart';
import '../filter/query_options.dart';
import 'models/report_data.dart';

class ReportPageBloc extends Cubit<ReportData> {
  final QueryFiltersBloc queryFiltersBloc;
  ReportPageBloc(this.queryFiltersBloc) : super(ReportData.empty());

  final _repository = ReportsRepository();

  void init(
      GroupBy groupBy, SortDirection sortDirection, ReportType type) async {
    if (type == ReportType.sales) {
      final query = queryFiltersBloc.getQuery();
      final reportData = await _repository.getSalesReportData(groupBy, query);
      emit(reportData);
      return;
    }

    late final List<String> items;
    switch (groupBy) {
      case GroupBy.day:
        items = days;
        break;
      case GroupBy.product:
        items = products;
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
    emit(ReportData.withoutAnnotations(
        reportType: type, items: items, amounts: amounts));
  }

  void refresh(
      GroupBy groupBy, SortDirection sortDirection, ReportType report) {
    init(groupBy, sortDirection, report);
  }
}
