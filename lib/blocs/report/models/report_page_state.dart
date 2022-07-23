import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';

import '../../../models/inventory_movement.dart';
import '../../../utils/extensions.dart/report_type.dart';
import 'price_list_report_data.dart';

class ReportPageState {
  final ReportType type;
  final ReportData? data;

  /// currently used for grouped-by-category stocks-status report. It contains all items
  /// in the [ReportPageState.data] but only grouped according to something from the
  /// server.
  final GroupedReportData? groupedReportData;
  final PriceListReportData? priceListReportData;
  final List<InventoryMovement>? inventoryMovements;
  final String? error;
  final bool isLoading;

  const ReportPageState(
      {this.error,
      this.data,
      this.type = ReportType.sales,
      this.isLoading = false,
      this.priceListReportData,
      this.inventoryMovements,
      this.groupedReportData});

  bool get hasError => error != null;

  bool get hasReportData => data != null;

  bool get hasGroupedReportData => groupedReportData != null;

  bool get hasInventoryMovements => inventoryMovements != null;

  ReportPageState copyWith(
      {ReportData? data,
      String? error,
      ReportType? type,
      GroupedReportData? groupedData,
      PriceListReportData? priceListReportData,
      List<InventoryMovement>? inventoryMovements,
      bool? isLoading}) {
    return ReportPageState(
        data: data ?? this.data,
        error: error,
        type: type ?? this.type,
        priceListReportData: priceListReportData ?? this.priceListReportData,
        groupedReportData: groupedData ?? groupedReportData,
        inventoryMovements: inventoryMovements ?? this.inventoryMovements,
        isLoading: isLoading ?? this.isLoading);
  }
}
