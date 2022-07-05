import 'package:inventory_management/blocs/report/models/grouped_report_data.dart';
import 'package:inventory_management/blocs/report/models/report_data.dart';

class ReportPageState {
  final ReportData data;

  /// currently used for grouped-by-category stocks-status report. It contains all items
  /// in the [ReportPageState.data] but only grouped according to something from the
  /// server.
  final GroupedReportData? groupedReportData;
  final String? error;
  final bool isLoading;

  const ReportPageState(
      {this.error,
      required this.data,
      required this.isLoading,
      this.groupedReportData});

  const ReportPageState.initial()
      : this(data: const ReportData.empty(), isLoading: false);

  bool get hasError => error != null;

  bool get hasNoData => data.items.isEmpty;

  ReportPageState copyWith(
      {ReportData? data,
      String? error,
      GroupedReportData? groupedData,
      bool? isLoading}) {
    return ReportPageState(
        data: data ?? this.data,
        error: error,
        groupedReportData: groupedData,
        isLoading: isLoading ?? this.isLoading);
  }
}
