import '../../../utils/extensions.dart/report_type.dart';
import 'annotation.dart';

class ReportData {
  final ReportType reportType;
  final List<String> items;
  final List<double> amounts;
  final Annotation measure, dimension;
  const ReportData(
      {required this.reportType,
      required this.items,
      required this.amounts,
      required this.measure,
      required this.dimension});

  factory ReportData.withoutAnnotations(
      {required ReportType reportType,
      required List<String> items,
      required List<double> amounts}) {
    return ReportData(
        reportType: reportType,
        items: items,
        amounts: amounts,
        measure: const Annotation.empty(),
        dimension: const Annotation.empty());
  }

  const ReportData.empty()
      : items = const [],
        reportType = ReportType.sales,
        measure = const Annotation.empty(),
        dimension = const Annotation.empty(),
        amounts = const [];
}
