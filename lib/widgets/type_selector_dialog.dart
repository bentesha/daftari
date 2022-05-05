import 'package:inventory_management/source.dart';
import 'package:inventory_management/utils/extensions.dart/report_type.dart';

enum Types { reports, dimensions }

class TypeSelectorDialog<T> extends Dialog {
  const TypeSelectorDialog(
      {required this.onSelected,
      required this.currentType,
      required this.title,
      Key? key})
      : super(key: key);

  final ValueChanged onSelected;
  final T currentType;
  final String title;

  @override
  Widget? get child {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        Center(
          child: AppText(title, size: 18.dw, weight: FontWeight.bold),
        ),
        AppDivider(margin: EdgeInsets.only(top: 15.dh)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 10.dh),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ReportType.values
                  .map((reportType) => _buildReportType(reportType))
                  .toList()),
        ),
      ],
    );
  }

  Widget _buildReportType(ReportType reportType) {
    final isSelected = reportType == currentType;
    return AppTextButton(
      text: reportType.string,
      onPressed: () {
        pop();
        if (T == ReportType) onSelected(reportType);
      },
      textStyle: TextStyle(
          color: isSelected ? AppColors.onPrimary : AppColors.onBackground2,
          fontSize: 14.dw),
      backgroundColor: isSelected ? AppColors.primary : AppColors.background,
      borderRadius: BorderRadius.circular(20.dw),
      height: 40.dh,
    );
  }

  @override
  Color? get backgroundColor => AppColors.background;

  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dw));
}
