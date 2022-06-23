import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/reports/data.dart';
import '../../repository/reports/reports_repository.dart';
import '../filter/query_filters_bloc.dart';
import '../filter/query_options.dart';
import 'models/report_data.dart';

class ReportPageBloc extends Cubit<ReportPageState> {
  final QueryFiltersBloc queryFiltersBloc;
  ReportPageBloc(this.queryFiltersBloc)
      : super(const ReportPageState.initial());

  final _repository = ReportsRepository();

  void init(
      GroupBy groupBy, SortDirection sortDirection, ReportType type) async {
    emit(state.copyWith(isLoading: true, error: null));

    if (type == ReportType.sales) {
      final query = queryFiltersBloc.getQuery();
      try {
        final reportData = await _repository.getSalesReportData(groupBy, query);
        emit(state.copyWith(data: reportData, isLoading: false));
      } catch (error) {
        emit(state.copyWith(isLoading: false, error: '$error'));
      }
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
    final data = ReportData.withoutAnnotations(
        reportType: type, items: items, amounts: amounts);
    emit(state.copyWith(data: data, isLoading: false));
  }

  void refresh(
      GroupBy groupBy, SortDirection sortDirection, ReportType report) {
    init(groupBy, sortDirection, report);
  }
}
