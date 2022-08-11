import 'package:intl/intl.dart';
import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';
import 'package:inventory_management/blocs/source.dart';
import 'package:inventory_management/models/today_statistics.dart';
import 'package:inventory_management/repository/reports/sales/sales_repository.dart';
import 'package:inventory_management/source.dart';

import '../../repository/reports/expenses/expenses_repository.dart';
import '../../repository/reports/products_repository.dart';
import '../../repository/reports/profit_loss_repository.dart';
import '../../repository/reports/purchases/purchases_repository.dart';
import '../../repository/reports/stocks/stock_repository.dart';

class DashBoardBloc extends Cubit<DashBoardState> {
  DashBoardBloc() : super(const DashBoardState());

  final _salesRepository = SalesRepository();
  final _productsRepository = ProductsRepository();
  final _expensesRepository = ExpensesRepository();
  final _stocksRepository = StocksRepository();
  final _profitLossRepository = ProfitLossRepository();
  final _purchasesRepository = PurchasesRepository();

  Future<void> getData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await _productsRepository.getProductsByStockQuantity();
      final recentSales = await _salesRepository.getRecentSales();
      final monthlySales = await _salesRepository.getSalesBreakdown();
      final monthlyExpenses = await _expensesRepository.getExpensesBreakdown();
      final productsInventorySummary =
          await _stocksRepository.getInventoryMovementSummary();
      final profitData = await _profitLossRepository.getProfitData();
      final stats = await _getTodayStats();
      emit(DashBoardState(
        profitData: profitData,
        products: products,
        recentSales: recentSales,
        revenueBreakdownData: monthlySales,
        productsInventorySummary: productsInventorySummary,
        expensesBreakdownData: monthlyExpenses,
        todayStats: stats,
      ));
    } catch (error) {
      emit(state.copyWith(error: '$error', isLoading: false));
    }
  }

  void refresh() => getData();

  Future<TodayStatistics> _getTodayStats() async {
    final sales = await _salesRepository.getTodaySalesTotal();
    final purchases = await _purchasesRepository.getTodayPurchasesTotal();
    final expenses = await _expensesRepository.getTodayExpensesTotal();
    final date = DateFormat("EEEE, dd-MM-yyyy").format(DateTime.now());

    return TodayStatistics(
        sales: sales, expenses: expenses, purchases: purchases, date: date);
  }
}
