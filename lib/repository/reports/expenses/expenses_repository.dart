import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import 'expenses_repository_mixin.dart';

class ExpensesRepository with ExpensesRepositoryMixin {
  Future<ReportData> getExpensesReportData(GroupBy groupBy, String query) async {
    try {
      log(query);
      final url = root + 'report/expenses?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      final items = getItems(groupBy, data);
      final amounts = data
          .map((e) => (e['ExpensesDetails.total'] as num).toDouble())
          .toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['ExpensesDetails.total']);
      final measure = Annotation.fromMap(measureMap);
      final dimension = getDimension(
          groupBy,
          groupBy.isTimeDimension
              ? result['annotations']['timeDimensions']
              : result['annotations']['dimensions']);

      return ReportData(
          reportType: ReportType.expenses,
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
