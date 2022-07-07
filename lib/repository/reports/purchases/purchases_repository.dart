import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/errors/error_handler_mixin.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../purchases/purchases_repository_mixin.dart';

class PurchasesRepository with PurchasesRepositoryMixin, ErrorHandler {
  Future<ReportData> getPurchasesReportData(
      GroupBy groupBy, String query) async {
    try {
      log(query);
      final url = root + 'report/purchase?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const ReportData.empty();

      final items = getItems(groupBy, data);
      final amounts = data
          .map((e) => (e['PurchaseDetail.total'] as num).toDouble())
          .toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['PurchaseDetail.total']);
      final measure = Annotation.fromMap(measureMap);
      final dimension = getDimension(
          groupBy,
          groupBy.isTimeDimension
              ? result['annotations']['timeDimensions']
              : result['annotations']['dimensions']);

      return ReportData(
          reportType: ReportType.purchases,
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
