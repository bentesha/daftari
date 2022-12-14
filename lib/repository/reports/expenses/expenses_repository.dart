import 'package:intl/intl.dart';
import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../../../errors/error_handler_mixin.dart';
import '../../../models/breakdown_data.dart';
import 'expenses_repository_mixin.dart';

class ExpensesRepository with ExpensesRepositoryMixin, ErrorHandler {
  Future<List<BreakdownData>> getExpensesBreakdown() async {
    final now = DateTime.now();
    final prevMonth = DateTime(now.year, now.month - 1, now.day);
    final formattedNow = Utils.convertDateToISOFormat(now);
    final formattedPrevMonth = Utils.convertDateToISOFormat(prevMonth);
    final url = root +
        'report/expense?startDate=$formattedPrevMonth&endDate=$formattedNow';
    try {
      final result = await http.get(url);
      var data = List<Map<String, dynamic>>.from(result['data']);
      if (data.isEmpty) return [];

      final total = data.fold<double>(
          0, (prev, current) => prev + current['ExpenseDetail.amount']);

      return data.map((e) {
        final amount = (e['ExpenseDetail.amount'] as num).toDouble();
        return BreakdownData(e['ExpenseCategory.name'], amount, amount / total);
      }).toList();
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }

  Future<ReportData> getExpensesReportData(
      GroupBy groupBy, String query) async {
    try {
      log(query);
      final url = root + 'report/expense?$query';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result['data']);

      if (data.isEmpty) return const ReportData.empty();

      final items = getItems(groupBy, data);
      final amounts = data
          .map((e) => (e['ExpenseDetail.amount'] as num).toDouble())
          .toList();
      final measureMap = Map<String, dynamic>.from(
          result['annotations']['measures']['ExpenseDetail.amount']);
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

  Future<double> getTodayExpensesTotal() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root + 'expense?date:gt=$date';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);
      final total = data.fold<num>(0, (prev, e) => prev + (e["total"] as num));
      return total.toDouble();
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }

  Future<List<Document>> getTodayExpensesDocuments() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root + 'expense?&date:gt=$date';
      final result = await http.get(url);
      log("$result");

      final data = List<Map<String, dynamic>>.from(result);
      if (data.isEmpty) return [];
      // final jsonDocuments = data.groupListsBy<String>((m) => m["documentId"]);

      final documents = <Document>[];
      for (var document in data) {
        final expenses = (document["details"] as List)
            .map((e) => Expense.fromJson(e))
            .toList();
        final form = DocumentForm.fromJson(document);
        documents.add(Document.expenses(form, expenses));
      }
      return documents;
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }
}
