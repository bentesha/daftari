import 'dart:developer';

import 'package:inventory_management/errors/error_handler_mixin.dart';
import 'package:inventory_management/models/profit_data.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../secret.dart';

class ProfitLossRepository with ErrorHandler {
  Future<ProfitData> getProfitData() async {
    try {
      // working for Total Gross Margin:
      const salesReportUrl = '${root}report/sales';
      final salesResults = await http.get(salesReportUrl);
      final productSales =
          List<Map<String, dynamic>>.from(salesResults['data']);
      final totalGrossMargin = productSales.fold<double>(
          0.0,
          (prev, current) =>
              prev + (current['SalesDetail.grossMargin'] as num).toDouble());

      // working for Total Expenses:
      const expensesReportUrl = '${root}report/expense';
      final expensesResults = await http.get(expensesReportUrl);
      final expenses = List<Map<String, dynamic>>.from(expensesResults['data']);
      final totalExpenses = expenses.fold<double>(
          0.0,
          (prev, current) =>
              prev + (current['ExpenseDetail.amount'] as num).toDouble());

      // working for Total Stock Write-off costs:
      const writeOffReportUrl = '${root}report/stock-writeoff?groupBy=type';
      final writeOffResults = await http.get(writeOffReportUrl);
      final writeOffs =
          List<Map<String, dynamic>>.from(writeOffResults['data']);
      final totalWriteOffCosts = writeOffs.fold<double>(
          0.0,
          (prev, current) =>
              prev +
              (current['StockWriteoffDetail.totalCost'] as num).toDouble());

      return ProfitData(
          totalExpenses: totalExpenses,
          totalGrossMargin: totalGrossMargin,
          totalStockWriteOffs: totalWriteOffCosts);
    } catch (error) {
      log("$error");
      final message = getError(error);
      throw message;
    }
  }
}
