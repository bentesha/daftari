import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';
import 'package:inventory_management/blocs/source.dart';
import 'package:inventory_management/repository/reports/sales/sales_repository.dart';
import 'package:inventory_management/source.dart';

import '../../repository/reports/expenses/expenses_repository.dart';
import '../../repository/reports/products_repository.dart';
import '../../repository/reports/stocks/stock_repository.dart';

class DashBoardBloc extends Cubit<DashBoardState> {
  DashBoardBloc() : super(const DashBoardState());

  final _salesRepository = SalesRepository();
  final _productsRepository = ProductsRepository();
  final _expensesRepository = ExpensesRepository();
  final _stocksRepository = StocksRepository();

  Future<void> getData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final products = await _productsRepository.getProductsByStockQuantity();
      final recentSales = await _salesRepository.getRecentSales();
      final monthlySales = await _salesRepository.getSalesBreakdown();
      final monthlyExpenses = await _expensesRepository.getExpensesBreakdown();
      final productsInventorySummary =
          await _stocksRepository.getInventoryMovementSummary();
      emit(DashBoardState(
          products: products,
          recentSales: recentSales,
          revenueBreakdownData: monthlySales,
          productsInventorySummary: productsInventorySummary,
          expensesBreakdownData: monthlyExpenses));
    } catch (error) {
      emit(state.copyWith(error: '$error', isLoading: false));
    }
  }
}
