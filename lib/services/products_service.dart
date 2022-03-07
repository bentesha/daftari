import 'dart:async';
import 'network_service.dart';
import '../source.dart';

class ProductsService extends NetworkService<Product> {
  ///Gets all products from the server
  Future<void> init() async => await super.getAll();
}
