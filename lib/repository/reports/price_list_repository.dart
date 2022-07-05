import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';

import '../../source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;

class PriceListReository {
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
          reportType: ReportType.priceList,
          items: items,
          amounts: amounts,
          measure: measure,
          dimension: dimension);
    } catch (error) {
      log('$error');
      final message = getErrorMessage(error);
      throw message;
    }
  }
}
