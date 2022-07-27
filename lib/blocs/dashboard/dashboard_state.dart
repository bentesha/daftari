import 'package:inventory_management/models/breakdown_data.dart';
import 'package:inventory_management/models/recent_sales.dart';
import 'package:inventory_management/models/today_statistics.dart';

import '../../models/product.dart';
import '../../models/profit_data.dart';

class DashBoardState {
  final List<BreakdownData> revenueBreakdownData, expensesBreakdownData;
  final List<RecentSale> recentSales;
  final List<Product> products, productsInventorySummary;
  final TodayStatistics todayStats;
  final ProfitData profitData;
  final bool isLoading;
  final String? error;
  const DashBoardState(
      {this.revenueBreakdownData = const [],
      this.expensesBreakdownData = const [],
      this.recentSales = const [],
      this.productsInventorySummary = const [],
      this.products = const [],
      this.isLoading = false,
      this.todayStats = const TodayStatistics(),
      this.profitData = const ProfitData(),
      this.error});

  DashBoardState copyWith({String? error, bool? isLoading}) {
    return DashBoardState(
      revenueBreakdownData: revenueBreakdownData,
      expensesBreakdownData: expensesBreakdownData,
      productsInventorySummary: productsInventorySummary,
      isLoading: isLoading ?? this.isLoading,
      recentSales: recentSales,
      profitData: profitData,
      products: products,
      error: error,
    );
  }

  bool get hasError => error != null;
}
