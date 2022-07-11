import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/repository/reports/stocks/stock_repository_mixin.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../../../blocs/report/models/annotation.dart';
import '../../../errors/error_handler_mixin.dart';
import '../../../models/inventory_movement.dart';
import '../../../models/product.dart';
import '../../../secret.dart';
import '../../../utils/extensions.dart/report_type.dart';
import 'stock_repository_mixin.dart';

class StocksRepository with StocksRepositoryMixin, ErrorHandler {
  Future<Either<ReportData, List<InventoryMovement>>> getInventoryMovements(
      String query, GroupBy? groupBy) async {
    log(query);
    try {
      final url = root + 'report/inventory-movement?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const Right([]);

      if (groupBy == null) {
        final inventoryMovements =
            data.map((e) => InventoryMovement.fromMap(e)).toList();
        return Right(inventoryMovements);
      } else {
        final items = getItems(groupBy, data);
        final amounts = data
            .map((e) => (e['InventoryMovement.totalValue'] as num).toInt())
            .toList();
        final measureMap = Map<String, dynamic>.from(
            result['annotations']['measures']['InventoryMovement.totalValue']);
        final measure = Annotation.fromMap(measureMap);
        final dimension = getDimension(
            groupBy,
            groupBy.isTimeDimension
                ? result['annotations']['timeDimensions']
                : result['annotations']['dimensions']);

        final reportData = ReportData(
          items: items,
          amounts: amounts,
          measure: measure,
          dimension: dimension,
        );
        return Left(reportData);
      }
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }

  Future<List<Product>> getInventoryMovementSummary([int? limit]) async {
    try {
      const url = root + 'report/inventory-movement?groupBy=product';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return [];

      final products = <Product>[];
      for (var product in data) {
        if (limit != null) if (products.length == limit) break;
        products.add(Product.fromInventoryMovementJson(product));
      }

      return products;
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }

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
        items: items,
        amounts: amounts,
        measure: Annotation.fromMap(measureMap),
        dimension: Annotation.fromMap(dimensionMap),
      );
    } catch (error) {
      log('$error');
      final message = getError(error);
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
      final message = getError(error);
      throw message;
    }
  }
}
