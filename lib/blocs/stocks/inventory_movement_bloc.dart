import 'package:inventory_management/blocs/stocks/inventory_movement_state.dart';
import 'package:inventory_management/repository/reports/stocks/stock_repository.dart';
import 'package:inventory_management/source.dart';

class InventoryMovementBloc extends Cubit<InventoryMovementState> {
  InventoryMovementBloc() : super(const InventoryMovementState());

  final _stocksRepository = StocksRepository();

  void addProduct(Product product) {
    emit(state.copyWith(
        isLoading: true, inventoryMovements: [], product: product));
    getInventoryMovementByProduct();
  }

  void refresh() => emit(const InventoryMovementState());

  Future<void> getInventoryMovementByProduct() async {
    try {
      final result = await _stocksRepository
          .getInventoryMovementByProductID(state.product!.id);
      emit(InventoryMovementState(
          inventoryMovements: inventoryMovements, product: state.product));
    } catch (error) {
      log('$error');
      emit(state.copyWith(error: '$error', isLoading: false));
    }
  }
}
