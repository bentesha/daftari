import 'package:inventory_management/blocs/report/models/annotation.dart';

import '../../../utils/extensions.dart/report_type.dart';

class GroupedReportData {
  final ReportType reportType;
  final List<Group> groups;
  final Annotation measure, dimension;

  const GroupedReportData(
      {required this.groups,
      required this.dimension,
      required this.measure,
      required this.reportType});

  const GroupedReportData.empty()
      : this(
            reportType: ReportType.remainingStock,
            groups: const [],
            dimension: const Annotation.empty(),
            measure: const Annotation.empty());
}

class Group {
  final String name;
  final List<String> items;
  final List<double> amounts;

  const Group(this.name, this.items, this.amounts);
}
