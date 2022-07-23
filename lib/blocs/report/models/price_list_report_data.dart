import '../../../models/source.dart';
import 'annotation.dart';

class PriceListReportData {
  final Annotation measure, dimension;
  final List<Product> products;

  const PriceListReportData(
      {required this.dimension, required this.measure, required this.products});

  PriceListReportData whereNameStartsWith(String query) {
    final results =
        products.where((e) => e.name.toLowerCase().startsWith(query)).toList();
    return PriceListReportData(
        dimension: dimension, measure: measure, products: results);
  }
}
