import 'dart:developer';

import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../models/product.dart';
import '../../secret.dart';
import '../../utils/global_functions.dart';

class ProductsRepository {
  /// Gets 5 products with the lowest stock quantity to show on the dashboard.
  Future<List<Product>> getProductsByStockQuantity() async {
    const url = root + 'product';

    try {
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);

      final products = <Product>[];
      for (var product in data) {
        if (products.length == 5) break;
        products.add(Product.fromJson(product));
      }
      return products;
    } catch (error) {
      log('$error');
      final message = getErrorMessage(error);
      throw message;
    }
  }
}
