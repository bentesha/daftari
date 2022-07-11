import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../../../errors/error_handler_mixin.dart';
import 'write_off_repository_mixin.dart';

class WriteOffRepository with WriteOffRepositoryMixin, ErrorHandler {
  Future<ReportData> geWriteOffsReportData(
      GroupBy groupBy, String query) async {
    try {
      log(query);
      final url = root + 'report/stock-writeoff?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const ReportData.empty();

      final items = getItems(groupBy, data);
      final amounts = data
          .map((e) => (e['StockWriteoffDetail.totalCost'] as num).toDouble())
          .toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['StockWriteoffDetail.totalCost']);
      final measure = Annotation.fromMap(measureMap);
      final dimension = getDimension(
          groupBy,
          groupBy.isTimeDimension
              ? result['annotations']['timeDimensions']
              : result['annotations']['dimensions']);

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
