import 'dart:async';
import 'service.dart';
import '../source.dart';

class ProductsService extends Service<Product> {
  static final box = Hive.box(Constants.kProductsBox);
  ProductsService() : super(box);

  static var _selectedId = '';

  List<Product> get getProductList => super.getList;
  String get getSelectedProductId => _selectedId;

  Product? getProductById(String id) => box.get(id) as Product?;

  Future<void> addProduct(Product product) async {
    _selectedId = product.id;
    await super.add(product);
  }

  ///Gets all products from the Hive database
  void init() => super.getAll();

  Future<void> editProduct(Product product) async => await super.edit(product);

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
