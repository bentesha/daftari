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

  List<Product> init() => super.getAll();

  Future<void> addProduct(Product product) async {
    _selectedId = product.id;
    super.add(Product);
  }

  Future<void> editProduct(Product product) async => super.edit(Product);

  void updateId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
