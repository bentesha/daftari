import 'dart:developer';

import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/repository/reports/stocks/stock_repository_mixin.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/report/models/annotation.dart';
import '../../../secret.dart';
import '../../../utils/extensions.dart/report_type.dart';
import '../../../utils/global_functions.dart';
import 'stock_repository_mixin.dart';

class StocksRepository with StocksRepositoryMixin {
  Future<ReportData> getStocksStatus(String query) async {
    try {
      log(query);
      final url = root + 'report/stock-status?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const ReportData.empty();

      final items = data.map((e) => e['Product.name'] as String).toList();
      final amounts = data
          .map((e) => (e['InventoryMovement.quantity'] as num).toInt())
          .toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['InventoryMovement.quantity']);
      final dimensionMap = Map<String, dynamic>.from(
          result['annotations']['dimensions']['Product.name']);

      return ReportData(
        reportType: ReportType.remainingStock,
        items: items,
        amounts: amounts,
        measure: Annotation.fromMap(measureMap),
        dimension: Annotation.fromMap(dimensionMap),
      );
    } catch (error) {
      log('$error');
      final message = getErrorMessage(error);
      throw message;
    }
  }

  Future<GroupedReportData> getGroupedStocksStatus(String query) async {
    try {
      log(query);
      final url = root + 'report/stock-status?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const GroupedReportData.empty();

      final groupNames = data.map((e) => e['Category.name']).toSet().toList();
      log('$groupNames');
      final groups = <Group>[];
      for (var groupName in groupNames) {
        final items = <String>[];
        final amounts = <double>[];
        final filteredData = data.where((e) => e['Category.name'] == groupName);
        for (var e in filteredData) {
          items.add(e['Product.name']);
          amounts.add((e['InventoryMovement.quantity'] as num).toDouble());
        }
        groups.add(Group(groupName, items, amounts));
      }

      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['InventoryMovement.quantity']);
      final dimensionMap = Map<String, dynamic>.from(
          result['annotations']['dimensions']['Product.name']);

      return GroupedReportData(
        reportType: ReportType.remainingStock,
        groups: groups,
        measure: Annotation.fromMap(measureMap),
        dimension: Annotation.fromMap(dimensionMap),
      );
    } catch (error) {
      log('$error');
      final message = getErrorMessage(error);
      throw message;
    }
  }
}
