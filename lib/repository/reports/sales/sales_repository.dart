import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../../../models/breakdown_data.dart';
import 'sales_repository_mixin.dart';

class SalesRepository with SalesRepositoryMixin {
  Future<List<BreakdownData>> getSalesBreakdown() async {
    final now = DateTime.now();
    final prevMonth = DateTime(now.year, now.month - 1, now.day);
    final formattedNow = Utils.convertDateToISOFormat(now);
    final formattedPrevMonth = Utils.convertDateToISOFormat(prevMonth);
    final url = root +
        'report/sales?groupBy=category&startDate=$formattedPrevMonth&endDate=$formattedNow';

    try {
      final result = await http.get(url);
      var data = List<Map<String, dynamic>>.from(result['data']);
      if (data.isEmpty) return [];

      final total = data.fold<double>(
          0, (prev, current) => prev + current['SalesDetail.total']);

      return data.map((e) {
        final amount = (e['SalesDetail.total'] as num).toDouble();
        return BreakdownData(e['Category.name'], amount, amount / total);
      }).toList();
    } catch (error) {
      log('$error');
      final message = getErrorMessage(error);
      throw message;
    }
  }

  Future<ReportData> getSalesReportData(GroupBy groupBy, String query) async {
    try {
      log(query);
      final url = root + 'report/sales?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      final items = getItems(groupBy, data);
      final amounts =
          data.map((e) => (e['SalesDetail.total'] as num).toDouble()).toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['SalesDetail.total']);
      final measure = Annotation.fromMap(measureMap);
      final dimension = getDimension(
          groupBy,
          groupBy.isTimeDimension
              ? result['annotations']['timeDimensions']
              : result['annotations']['dimensions']);

      return ReportData(
          reportType: ReportType.sales,
          items: items,
          amounts: amounts,
          measure: measure,
          dimension: dimension);
    } catch (error) {
      final message = getErrorMessage(error);
      throw message;
    }
  }
}
