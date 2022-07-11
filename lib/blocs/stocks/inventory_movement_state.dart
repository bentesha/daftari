import 'package:inventory_management/models/inventory_movement.dart';
import 'package:inventory_management/source.dart';

import '../report/models/report_data.dart';

class InventoryMovementState {
  /// Inventory moevements for a specific [product]
  final List<InventoryMovement>? inventoryMovements;
  final ReportData? reportData;

  /// Selected product whose inventory-movements are viewed
  final Product? product;
  final bool isLoading;
  final String? error;
  const InventoryMovementState(
      {this.inventoryMovements,
      this.reportData,
      this.isLoading = false,
      this.product,
      this.error});

  InventoryMovementState copyWith(
      {String? error,
      bool? isLoading,
      Product? product,
      List<InventoryMovement>? inventoryMovements}) {
    return InventoryMovementState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      inventoryMovements: inventoryMovements ?? this.inventoryMovements,
      error: error,
    );
  }

  bool get hasError => error != null;

  bool get hasNoData => inventoryMovements == null && inventoryMovements!.isEmpty;
}
