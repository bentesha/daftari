import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/source.dart';
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
    if (type.hasItsOwnImpl) {
      final reportData = ReportData.withoutAnnotations(
          reportType: type, amounts: [], items: []);
      emit(state.copyWith(data: reportData));
      return;
    }
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
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: '$error'));
    }
  }

  void refresh(
      GroupBy groupBy, SortDirection sortDirection, ReportType report) {
    init(sortDirection, report, groupBy);
  }
}
