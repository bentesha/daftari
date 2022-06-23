import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/repository/reports/recent_sales.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../blocs/filter/query_options.dart';
import 'reports_repository_mixin.dart';

class ReportsRepository with ReportsRepositoryMixin {
  Future<List<RecentSales>> getRecentSales() async {
    const url = root + 'report/sales';
    final result = await http.get(url);
    var data = List<Map<String, dynamic>>.from(result['data']);
    if (data.length > 5) {
      data = data.getRange(data.length - 5, data.length).toList();
    }
    return data.map((e) => RecentSales.fromMap(e)).toList();
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
