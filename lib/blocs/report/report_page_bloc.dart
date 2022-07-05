import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/reports/data.dart';
import '../../repository/reports/expenses/expenses_repository.dart';
import '../../repository/reports/price_list_repository.dart';
import '../../repository/reports/purchases/purchases_repository.dart';
import '../../repository/reports/sales/sales_repository.dart';
import '../../repository/reports/stocks/stock_repository.dart';
import '../filter/query_filters_bloc.dart';
import '../filter/query_options.dart';
import 'models/report_data.dart';

class ReportPageBloc extends Cubit<ReportPageState> {
  final QueryFiltersBloc queryFiltersBloc;
  ReportPageBloc(this.queryFiltersBloc)
      : super(const ReportPageState.initial());

  final _salesRepository = SalesRepository();
  final _purchasesRepository = PurchasesRepository();
  final _expensesRepository = ExpensesRepository();
  final _priceListRepository = PriceListReository();
  final _stocksRepository = StocksRepository();

  void init(SortDirection sortDirection, ReportType type,
      [GroupBy? groupBy]) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
       ReportData? reportData;
      GroupedReportData? groupedReportData;

      if (type.isPriceList) {
        reportData = await _priceListRepository.getPriceList();
        emit(state.copyWith(data: reportData, isLoading: false));
        return;
      }

      if (type.hasFilters) {
        final query = queryFiltersBloc.getQuery();

        if (type.isSales) {
          reportData =
              await _salesRepository.getSalesReportData(groupBy!, query);
        }
        if (type.isPurchases) {
          reportData = await _purchasesRepository.getPurchasesReportData(
              groupBy!, query);
        }
        if (type.isExpenses) {
          reportData =
              await _expensesRepository.getExpensesReportData(groupBy!, query);
        }
        if (type.isRemainingStock) {
          final currentSortBy =
              (queryFiltersBloc['sortBy'] as SortByFilter).value;
          if (currentSortBy == SortBy.category) {
            groupedReportData =
                await _stocksRepository.getGroupedStocksStatus(query);
          } else {
            reportData = await _stocksRepository.getStocksStatus(query);
          }
        }

        emit(state.copyWith(
            data: reportData,
            groupedData: groupedReportData,
            isLoading: false));
        return;
      }

      // fake items for categories with no api impl
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
          items = productCategories;
          break;
        case null:
      }

      // random amounts for categories with no apis impl.
      final amounts = Utils.getRandomAmounts();

      if (sortDirection == SortDirection.ascending) {
        amounts.sort((a, b) => a.compareTo(b));
      } else {
        amounts.sort((a, b) => b.compareTo(a));
      }
      final data = ReportData.withoutAnnotations(
          reportType: type, items: items, amounts: amounts);
      emit(state.copyWith(data: data, isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: '$error'));
    }
  }

  void refresh(
      GroupBy groupBy, SortDirection sortDirection, ReportType report) {
    init(sortDirection, report, groupBy);
  }
}
