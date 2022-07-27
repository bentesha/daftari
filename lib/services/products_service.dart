import 'dart:async';
import 'with_no_document_base_service.dart';
import '../source.dart';

class ProductsService extends WithNoDocumentBaseService<Product> {
  ///Gets all products from the server
  Future<void> init() async => await super.getAll();

  Product getProductByID(String productID) {
    return super.getList.where((e) => e.id == productID).first;
  }
}
