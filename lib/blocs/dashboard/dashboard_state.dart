import 'package:inventory_management/repository/reports/recent_sales.dart';

class DashBoardState {
  final List<RecentSales> recentSalesList;
  final bool isLoading;
  final String? error;
  const DashBoardState(
      {this.recentSalesList = const [], this.isLoading = false, this.error});

  DashBoardState copyWith(
      {List<RecentSales>? recentSales, String? error, bool? isLoading}) {
    return DashBoardState(
        recentSalesList: recentSales ?? recentSalesList,
        error: error,
        isLoading: isLoading ?? this.isLoading);
  }
}
