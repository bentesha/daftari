import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_page_state.dart';
import 'package:inventory_management/models/inventory_movement.dart';
import 'package:inventory_management/source.dart';
import '../../repository/reports/expenses/expenses_repository.dart';
import '../../repository/reports/price_list_repository.dart';
import '../../repository/reports/purchases/purchases_repository.dart';
import '../../repository/reports/sales/sales_repository.dart';
import '../../repository/reports/stocks/stock_repository.dart';
import '../../repository/reports/write_off/write_off_repository.dart';
import '../filter/query_filters_bloc.dart';
import '../filter/query_options.dart';
import 'models/report_data.dart';

class ReportPageBloc extends Cubit<ReportPageState> {
  final QueryFiltersBloc queryFiltersBloc;
  ReportPageBloc(this.queryFiltersBloc) : super(const ReportPageState());

  final _salesRepository = SalesRepository();
  final _purchasesRepository = PurchasesRepository();
  final _expensesRepository = ExpensesRepository();
  final _priceListRepository = PriceListReository();
  final _stocksRepository = StocksRepository();
  final _writeOffrepository = WriteOffRepository();

  void init(ReportType type) async {
    final groupBy = (queryFiltersBloc['groupBy'] as GroupByFilter?)?.value;
    if (type.isProfitLoss) {
      final reportData = ReportData.withoutAnnotations(
          reportType: type, amounts: [], items: []);
      emit(state.copyWith(data: reportData, type: type));
      return;
    }

    if (type.isInventoryMovement) {
      final product = (queryFiltersBloc['product'] as ProductFilter?)?.value;
      if (product == null) {
        emit(ReportPageState(type: type));
        return;
      }
    }

    emit(state.copyWith(isLoading: true, error: null, type: type));

    try {
      ReportData? reportData;
      GroupedReportData? groupedReportData;
      List<InventoryMovement>? inventoryMovements;

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
        if (type.isInventoryMovement) {
          final result =
              await _stocksRepository.getInventoryMovements(query, groupBy);
          if (result.isLeft()) {
            reportData = result.fold((data) => data, (r) => null);
          } else {
            inventoryMovements = result.fold((_) => null, (data) => data);
          }
        }
        if (type.isWriteOff) {
          reportData =
              await _writeOffrepository.geWriteOffsReportData(groupBy!, query);
        }

        emit(ReportPageState(
            type: type,
            data: reportData,
            groupedReportData: groupedReportData,
            inventoryMovements: inventoryMovements));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: '$error'));
    }
  }

  void refresh(ReportType report) => init(report);
}
