import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';

import '../../errors/error_handler_mixin.dart';
import '../../source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

class PriceListReository with  ErrorHandler  {
  Future<ReportData> getPriceList() async {
    try {
      const url = root + 'product';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);

      final items = data.map((e) => e['name'] as String).toList();
      final amounts =
          data.map((e) => (e['unitPrice'] as num).toDouble()).toList();
      const measure = Annotation('Price', 'Price', 'string');
      const dimension = Annotation('Product', 'Product', 'string');

      return ReportData(
          items: items,
          amounts: amounts,
          measure: measure,
          dimension: dimension);
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }
}
