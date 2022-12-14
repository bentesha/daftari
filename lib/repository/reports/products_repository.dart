import 'dart:developer';

import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../blocs/report/models/annotation.dart';
import '../../blocs/report/models/price_list_report_data.dart';
import '../../errors/error_handler_mixin.dart';
import '../../models/product.dart';
import '../../secret.dart';

class ProductsRepository with ErrorHandler {
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
      products.sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));
      return products;
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }

  Future<PriceListReportData> getPriceList() async {
    try {
      const url = root + 'product';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);

      final products = data.map((e) => Product.fromJson(e)).toList();
      const measure = Annotation('Price', 'Price', 'string');
      const dimension = Annotation('Product', 'Product', 'string');

      return PriceListReportData(
          products: products, measure: measure, dimension: dimension);
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }
}
