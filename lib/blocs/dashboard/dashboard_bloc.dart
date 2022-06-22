import 'package:inventory_management/blocs/dashboard/dashboard_state.dart';
import 'package:inventory_management/blocs/source.dart';
import 'package:inventory_management/repository/reports/reports_repository.dart';

class DashBoardBloc extends Cubit<DashBoardState> {
  DashBoardBloc() : super(const DashBoardState());

  final _repository = ReportsRepository();

  void getData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final recentSales = await _repository.getRecentSales();
      emit(DashBoardState(recentSalesList: recentSales));
    } catch (error) {
      emit(state.copyWith(error: '$error'));
    }
  }
}
