import 'package:inventory_management/blocs/report/models/report_data.dart';

class ReportPageState {
  final ReportData data;
  final String? error;
  final bool isLoading;

  const ReportPageState(
      {required this.data, this.error, required this.isLoading});

  const ReportPageState.initial()
      : this(data: const ReportData.empty(), isLoading: false);

  bool get hasError => error != null;

  bool get hasNoData => data.items.isEmpty;

  ReportPageState copyWith({ReportData? data, String? error, bool? isLoading}) {
    return ReportPageState(
        data: data ?? this.data,
        error: error,
        isLoading: isLoading ?? this.isLoading);
  }
}
