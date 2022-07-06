import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';
import 'package:inventory_management/blocs/source.dart';
import 'package:inventory_management/repository/reports/sales/sales_repository.dart';
import 'package:inventory_management/source.dart';

import '../../repository/reports/expenses/expenses_repository.dart';

class DashBoardBloc extends Cubit<DashBoardState> {
  DashBoardBloc() : super(const DashBoardState());

  final _salesRepository = SalesRepository();
  final _expensesRepository = ExpensesRepository();

  void getData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final monthlySales = await _salesRepository.getSalesBreakdown();
      final monthlyExpenses = await _expensesRepository.getExpensesBreakdown();
      emit(DashBoardState(
          revenueBreakdownData: monthlySales,
          expensesBreakdownData: monthlyExpenses));
    } catch (error) {
      emit(state.copyWith(error: '$error', isLoading: false));
    }
  }
}
