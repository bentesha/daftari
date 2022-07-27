import 'package:intl/intl.dart';
import 'package:inventory_management/blocs/report/models/annotation.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/http_utils.dart' as http;
import '../../../blocs/filter/query_options.dart';
import '../../../errors/error_handler_mixin.dart';
import '../../../models/breakdown_data.dart';
import '../../../models/recent_sales.dart';
import 'sales_repository_mixin.dart';

class SalesRepository with SalesRepositoryMixin, ErrorHandler {
  Future<List<RecentSale>> getRecentSales() async {
    const url = root + 'sales?eager=[details.product]';

    try {
      final result = await http.get(url);
      var salesDocuments = List<Map<String, dynamic>>.from(result);
      if (salesDocuments.isEmpty) return [];

      final recentSales = <RecentSale>[];

      for (Map<String, dynamic> document in salesDocuments) {
        if (recentSales.length == 5) break;
        final details = List<Map<String, dynamic>>.from(document['details']);
        for (var sale in details) {
          if (recentSales.length == 5) break;
          recentSales.add(RecentSale.fromMap(sale));
        }
      }
      return recentSales;
    } catch (error) {
      log('$error');
      final message = getError(error);
      throw message;
    }
  }

  /// Gets a list of information necessary for drawing a revenue chart.
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
      final message = getError(error);
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
          items: items,
          amounts: amounts,
          measure: measure,
          dimension: dimension);
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }

  Future<double> getTodaySalesTotal() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root + 'sales?date:gt=$date';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);
      final total = data.fold<num>(0, (prev, e) => prev + (e["total"] as num));
      return total.toDouble();
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }

  Future<List<Document>> getTodaySalesDocuments() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root +
          'sales/detail?&date:gt=$date&eager=[document, product]&orderByDesc=document.date';
      final result = await http.get(url);
      log("$result");

      final data = List<Map<String, dynamic>>.from(result);
      if (data.isEmpty) return [];
      final jsonDocuments = data.groupListsBy<String>((m) => m["documentId"]);

      final documents = <Document>[];
      for (var documentId in jsonDocuments.keys) {
        final jsonDocument = jsonDocuments[documentId]!;
        final sales = <Sales>[];
        late DocumentForm form;
        for (var e in jsonDocument) {
          form = DocumentForm.fromJson(e["document"]);
          sales.add(Sales.fromJson(e));
        }
        documents.add(Document.sales(form, sales));
      }
      return documents;
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }
}
