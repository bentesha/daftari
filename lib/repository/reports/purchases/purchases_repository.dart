import 'package:intl/intl.dart';
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

  Future<double> getTodayPurchasesTotal() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root + 'purchase?date:gt=$date';
      final result = await http.get(url);
      final data = List<Map<String, dynamic>>.from(result);
      final total = data.fold<num>(0, (prev, e) => prev + (e["total"] as num));
      return total.toDouble();
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }

  Future<List<Document>> getTodayPurchasesDocuments() async {
    final now = DateTime.now();
    final date = DateFormat("yyyy-MM-dd").format(now);
    try {
      final url = root + 'purchase?&date:gt=$date';
      final result = await http.get(url);
      log("$result");

      final data = List<Map<String, dynamic>>.from(result);
      if (data.isEmpty) return [];
      // final jsonDocuments = data.groupListsBy<String>((m) => m["documentId"]);

      final documents = <Document>[];
      for (var document in data) {
        final purchases = (document["details"] as List)
            .map((e) => Purchase.fromJson(e))
            .toList();
        final form = DocumentForm.fromJson(document);
        documents.add(Document.purchases(form, purchases));
      }
      return documents;
    } catch (error) {
      final message = getError(error);
      throw message;
    }
  }
}
