import 'dart:async';
import 'service.dart';
import '../source.dart';

class ProductsService extends Service<Product> {
  static final box = Hive.box(Constants.kProductsBox);
  ProductsService() : super(box);

  static var _selectedId = '';
  String get getSelectedProductId => _selectedId;
  Product? get getCurrent => super.getById(_selectedId);

  Future<void> addProduct(Product product) async {
    _selectedId = product.id;
    await super.add(product);
  }

  ///Gets all products from the Hive database
  void init() => super.getAll();

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
