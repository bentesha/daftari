import 'package:inventory_management/models/breakdown_data.dart';

class DashBoardState {
  final List<BreakdownData> revenueBreakdownData;
  final List<BreakdownData> expensesBreakdownData;
  final bool isLoading;
  final String? error;
  const DashBoardState(
      {this.revenueBreakdownData = const [],
      this.expensesBreakdownData = const [],
      this.isLoading = false,
      this.error});

  DashBoardState copyWith(
      {List<BreakdownData>? recentSales, String? error, bool? isLoading}) {
    return DashBoardState(
        revenueBreakdownData: recentSales ?? revenueBreakdownData,
        error: error,
        isLoading: isLoading ?? this.isLoading);
  }

  bool get hasError => error != null;
}
