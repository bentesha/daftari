import 'package:inventory_management/models/breakdown_data.dart';
import 'package:inventory_management/models/recent_sales.dart';

import '../../models/product.dart';

class DashBoardState {
  final List<BreakdownData> revenueBreakdownData, expensesBreakdownData;
  final List<RecentSale> recentSales;
  final List<Product> products;
  final bool isLoading;
  final String? error;
  const DashBoardState(
      {this.revenueBreakdownData = const [],
      this.expensesBreakdownData = const [],
      this.recentSales = const [],
      this.products = const [],
      this.isLoading = false,
      this.error});

  DashBoardState copyWith({String? error, bool? isLoading}) {
    return DashBoardState(
      revenueBreakdownData: revenueBreakdownData,
      expensesBreakdownData: expensesBreakdownData,
      isLoading: isLoading ?? this.isLoading,
      recentSales: recentSales,
      products: products,
      error: error,
    );
  }

  bool get hasError => error != null;
}
