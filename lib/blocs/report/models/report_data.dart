import '../../../utils/extensions.dart/report_type.dart';
import 'annotation.dart';

class ReportData {
  final List<String> items;
  final List<num> amounts;
  final Annotation measure, dimension;
  const ReportData(
      {required this.items,
      required this.amounts,
      required this.measure,
      required this.dimension});

  factory ReportData.withoutAnnotations(
      {required ReportType reportType,
      required List<String> items,
      required List<double> amounts}) {
    return ReportData(
        items: items,
        amounts: amounts,
        measure: const Annotation.empty(),
        dimension: const Annotation.empty());
  }

  const ReportData.empty()
      : items = const [],
        measure = const Annotation.empty(),
        dimension = const Annotation.empty(),
        amounts = const [];
}
